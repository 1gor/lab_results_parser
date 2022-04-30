# frozen_string_literal: true

require './parser'
require 'minitest/spec'
require 'minitest/autorun'

describe Parser do
  let(:file_path) { './lab2.txt' }
  let(:parser) { Parser.new(file_path) }
  let(:valid_results) do
    [
      LaboratoryTestResult.new(code: 'A250', result: -1.0, format: 'boolean', comment: 'Comment for NEGATIVE result'),
      LaboratoryTestResult.new(code: 'B250', result: -2.0, format: 'nil_3plus',
                               comment: "Comment 1 for ++ result\nComment 2 for ++ result")
    ]
  end

  it 'has file_path attribute' do
    assert_equal './lab2.txt', parser.file_path
  end

  it 'produces valid results' do
    results = parser.mapped_results
    assert results.is_a?(Array)
    assert_equal valid_results, results
  end

  describe 'Invalid input' do
    it 'returns an error for unexpected code' do
      error = assert_raises(UnexpectedInput) do
        Parser.new('./lab3.txt').mapped_results
      end
      assert_equal 'Test code XXX unexpected', error.message
    end
  end
end
