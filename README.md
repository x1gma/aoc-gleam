# Advent of Code '23

This is my learning path for Gleam in the AoC 2023 and my first ever contact with Gleam and Erlang/BEAM. Any stupidity is not by design and feedback is surely welcome!

I am also trying to avoid dependencies as much as possible to get the basics of the stdlib and mess around with the language itself, with the exception of [gladvent](https://hexdocs.pm/gladvent/) because im also lazy.

## Installation

Install gleam and erlang as described in the [official docs](https://gleam.run/getting-started/installing/)

## Running

```sh
# Scaffold a new day
gleam run -m gladvent new <DAY>
# Running a specific day
gleam run -m gladvent run <DAY>
# If you're from the future, dont forget to append --year=2023
```