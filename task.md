# Lab Results Parser

Implement a solution to read and parse a text file which represents some laboratory test results.

## Goals

We use this test to evaluate:

- Basic knowledge of git
- Basic knowledge of ruby language
- Your object-oriented programming skils
- Unit testing understaning
- Code cleanliness

## Requirements

- Implement the `Parser` class
- Unit tests using `RSpec` or `Test::Unit`
- Upload the code to a git repository. It can be private, just give access to rodrigo.aquino@fullhealthmedical.com

## Lab results file

Here is an example of the lab results file to be parsed.

```
OBX|1|C100|20.0|
NTE|1|Comment for C100 result|
OBX|2|C200|500|
NTE|2|Comment for C200 result|
OBX|3|A250|NEGATIVE|
NTE|3|Comment for NEGATIVE result|
OBX|4|B250|++|
NTE|4|Comment 1 for ++ result|
NTE|4|Comment 2 for ++ result|
```

### File Format

A laboratory results file may contain one or more test results. Each laboratory result is reported in 2 or more lines:

- The first line of each test result starts with the string `OBX` followed by an integer which represents the index for the laboratory result.
- The following lines contain the comments for the test result. Each comment line starts with the string `NTE` and has the same index of its laboratory result.


## Laboratory result codes

These are the test codes with the format they're reported.

| Code | format |
| ---  | --- |
| C100 | float |
| C200 | float |
| A250 | boolean |
| B250 | nil_3plus |

### Laboratory result format

As explained above, each laboratory result is reported in a specific format.

The table below maps how each input from the laboratory results file should be mapped to the class `LaboratoryTestResult`:

| Format | input value | Mapped value
| ---  | --- | --- |
| float | `'20'` | 20.0  |
| boolean | `'NEGATIVE'` | -1.0 |
| boolean | `'POSITIVE'` | -2.0 |
| nil_3plus | `'NIL'` | -1.0
| nil_3plus | `'+'` | -2.0
| nil_3plus | `'++'` | -2.0
| nil_3plus | `'+++'` | -3.0


## Implementation

This section explains the 2 required classes to use on this solution.

### LaboratoryTestResult

For the purpose of this test a plain Ruby class can be used. The fields are commented below.

```
class LaboratoryTestResult
  # attributes
  #   :code
  #   :result
  #   :format
  #   :comment
end
```

### Parser

The parser receives the file path of the laboratory test results file and responds to the method
`mapped_results` which returns an array of `LaboratoryTestResult`

```
class Parser
  def initialize(file_path)
    # ...
  end

  def mapped_results
    # ...
  end
end

file_path = "/tmp/result1.txt"
parser = Parser.new(file_path)
parser.mapped_results
# => [...]
```

## Examples and expected result

/lab1.txt

```
OBX|1|C100|20.0|
NTE|1|Comment for C100 result|
```

```
parser = Parser.new('/lab1.txt')
parser.mapped_results
# => [ LaboratoryTestResult.new(code: 'C100', result: 20.0, format: 'float', comment: 'Comment for C100 result') ]
```

/lab2.txt
```
OBX|1|A250|NEGATIVE|
NTE|1|Comment for NEGATIVE result|
OBX|2|B250|++|
NTE|2|Comment 1 for ++ result|
NTE|2|Comment 2 for ++ result|
```

```
parser = Parser.new('/lab2.txt')
parser.mapped_results # => [
 LaboratoryTestResult.new(code: 'A250', result: -1.0, format: 'boolean', comment: 'Comment for NEGATIVE result'),
 LaboratoryTestResult.new(code: 'B250', result: -2.0, format: 'nil_3plus', comment: "Comment 1 for ++ result\nComment 2 for ++ result")
]
```


---

If something isn't clear you're free to make assumptions.
You can reach me through the email: rodrigo.aquino@fullhealthmedical.com.
