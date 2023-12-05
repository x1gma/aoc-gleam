import gleam/string
import gleam/list
import gleam/int
import gleam/regex
import gleam/option

const first_number_regex = "^.*?([0-9]|one|two|three|four|five|six|seven|eight|nine|zero).*$"

const last_number_regex = "^.*([0-9]|one|two|three|four|five|six|seven|eight|nine|zero).*?$"

pub fn pt_1(input: String) {
  string.split(input, on: "\n")
  |> list.map(parse_calibration_value)
  |> int.sum
}

pub fn pt_2(input: String) {
  string.split(input, on: "\n")
  |> list.map(parse_calibration_value_stringified)
  |> int.sum
}

fn parse_calibration_value(in: String) -> Int {
  string.to_graphemes(in)
  |> list.filter_map(int.parse)
  |> combine_calibration_value()
}

fn parse_calibration_value_stringified(in: String) -> Int {
  let assert Ok(first) = match_calibration_value(in, first_number_regex)
  let assert Ok(last) = match_calibration_value(in, last_number_regex)
  let assert Ok(result) = int.undigits([parse_int(first), parse_int(last)], 10)
  result
}

fn match_calibration_value(in: String, pattern: String) -> Result(String, Nil) {
  let assert Ok(regex_pattern) = regex.from_string(pattern)
  regex.scan(with: regex_pattern, content: in)
  |> list.flat_map(fn(x: regex.Match) { x.submatches })
  |> list.filter(option.is_some)
  |> list.map(fn(x) { option.unwrap(x, "") })
  |> list.first
}

fn combine_calibration_value(values: List(Int)) -> Int {
  let [first, ..] = values
  let last = case list.reverse(values) {
    [only] -> only
    [first, ..] -> first
  }
  let assert Ok(result) = int.undigits([first, last], 10)
  result
}

fn parse_int(value: String) -> Int {
  case value {
    "1" | "one" -> 1
    "2" | "two" -> 2
    "3" | "three" -> 3
    "4" | "four" -> 4
    "5" | "five" -> 5
    "6" | "six" -> 6
    "7" | "seven" -> 7
    "8" | "eight" -> 8
    "9" | "nine" -> 9
    "0" | "zero" -> 0
    _ -> panic
  }
}
