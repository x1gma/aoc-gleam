import gleam/string
import gleam/int
import gleam/iterator
import gleam/list

pub fn pt_1(input: String) {
  string.split(input, on: "\n")
  |> iterator.from_list
  |> iterator.map(parse_game)
  |> iterator.filter(is_possible)
  |> iterator.map(fn(game) { game.id })
  |> iterator.fold(0, int.add)
}

pub fn pt_2(input: String) {
  string.split(input, on: "\n")
  |> iterator.from_list
  |> iterator.map(parse_game)
  |> iterator.map(minimum_round)
  |> iterator.map(fn(round) { round.red * round.green * round.blue })
  |> iterator.fold(0, int.add)
}

type Round {
  Round(red: Int, green: Int, blue: Int)
}

type Game {
  Game(id: Int, rounds: List(Round))
}

fn minimum_round(game: Game) -> Round {
  game.rounds
  |> list.fold(
    Round(0, 0, 0),
    fn(acc, round) {
      Round(
        red: int.max(round.red, acc.red),
        blue: int.max(round.blue, acc.blue),
        green: int.max(round.green, acc.green),
      )
    },
  )
}

fn is_possible(game: Game) -> Bool {
  iterator.from_list(game.rounds)
  |> iterator.all(fn(round) {
    round.red <= 12 && round.green <= 13 && round.blue <= 14
  })
}

fn parse_game_id(in: String) -> Int {
  let assert Ok(#(_, id_string)) = string.split_once(in, on: " ")
  let assert Ok(id) = int.parse(id_string)
  id
}

fn parse_round(in: String) -> Round {
  string.split(in, on: ", ")
  |> list.fold(
    Round(0, 0, 0),
    fn(round, x) {
      let assert Ok(#(count_str, color_str)) = string.split_once(x, on: " ")
      let assert Ok(count) = int.parse(count_str)
      case color_str {
        "red" -> Round(..round, red: round.red + count)
        "green" -> Round(..round, green: round.green + count)
        "blue" -> Round(..round, blue: round.blue + count)
      }
    },
  )
}

fn parse_rounds(in: String) -> List(Round) {
  string.split(in, on: "; ")
  |> iterator.from_list
  |> iterator.map(parse_round)
  |> iterator.to_list
}

fn parse_game(in: String) -> Game {
  let assert Ok(#(game, rounds)) = string.split_once(in, on: ": ")
  Game(parse_game_id(game), parse_rounds(rounds))
}
