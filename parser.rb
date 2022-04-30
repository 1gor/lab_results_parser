# frozen_string_literal: true

require 'ostruct'
class LaboratoryTestResult < OpenStruct; end

class UnexpectedInput < StandardError; end

# Parses data files and returns array of LaboratoryTestResult objects
class Parser
  attr :file_path

  FORMAT = {
    'C100' => 'float',
    'C200' => 'float',
    'A250' => 'boolean',
    'B250' => 'nil_3plus'
  }.freeze

  FORMAT_MAP = {
    'NEGATIVE' => -1.0,
    'POSITIVE' => -2.0,
    'NIL' => -1.0,
    '+' => -2.0,
    '++' => -2.0,
    '+++' => -3.0
  }.freeze

  def initialize(file_path)
    @file_path = file_path
  end

  def mapped_results
    results = {}
    File.foreach(file_path).map do |line|
      row = line.split('|')
      raise UnexpectedInput, "Test code #{row[0]} unexpected" unless %(OBX NTE).include?(row[0])

      send(:"process_#{row[0].downcase}_row", row, results)
    end
    results.map do |_, v|
      LaboratoryTestResult.new(v.slice(:code, :result, :format, :comment)).freeze
    end
  end

  private

  def process_obx_row(row, results)
    h = Hash[%I[kind id code result].zip(row)]
    results.store(row[1], h)
    format, value = convert(h[:code], h[:result])
    results[row[1]].store(:format, format)
    results[row[1]].store(:result, value)
  end

  def process_nte_row(row, results)
    h = Hash[%I[kind id comment].zip(row)]
    raise UnexpectedInput, "Comment for non-existing id #{row[1]}" unless results[row[1]]

    comment = [results[row[1]][:comment], h[:comment]].join("\n")
    results[row[1]][:comment] = comment.strip
  end

  def convert(code, value)
    format = FORMAT[code]
    value = if format == 'float'
              value.to_f
            else
              FORMAT_MAP[value]
            end
    [format, value]
  end
end
