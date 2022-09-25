type joke = {
  id: int,
  setup: string,
  punchline: string,
}

type stateContext = {
  current: int,
  jokes: array<joke>,
}

type states = Initial | Loading | Success(stateContext)

type events = FetchJokes | FetchSuccess(stateContext)

module Decode = {
  open Json.Decode

  let joke = json => {
    id: json|>field("id", int),
    setup: json|>field("setup", string),
    punchline: json|>field("punchline", string),
  }

  let jokes = array(joke)
}

let fetchJokes = () => {
  open Js.Promise

  Fetch.fetch("https://official-joke-api.appspot.com/jokes/programming/ten")
  |> then_(Fetch.Response.json)
  |> then_(json => json->Decode.jokes->resolve)
}

let reducer = (state, event) =>
  switch (state, event) {
    | (Initial, FetchJokes) => Loading
    | (Loading, FetchSuccess(data)) => Success(data)
    | (Success(_), FetchJokes) => Loading
    | (Initial, FetchSuccess(_))
    | (Success(_), FetchSuccess(_))
    | (Loading, FetchJokes) => state
  }
