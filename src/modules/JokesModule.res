type joke = {
  id: int,
  setup: string,
  punchline: string,
}

type stateContext = {
  mutable current: int,
  mutable jokes: array<joke>,
}

let context = {
  current: 0,
  jokes: [],
}

type states = Loading | Success(stateContext)

type actions = FetchJokes | FetchSuccess(stateContext)

module Decode = {
  open Json.Decode

  let joke = json => {
    id: json|>field("id", int),
    setup: json|>field("setup", string),
    punchline: json|>field("punchline", string),
  }

  let jokes = array(joke)
}

let fetchJokes = async () => {
  let res = await Fetch.fetch("https://official-joke-api.appspot.com/jokes/programming/ten")
  (await res->Fetch.Response.json)->Decode.jokes
}

let reducer = (state, action) =>
  switch (state, action) {
    | (Loading, FetchSuccess(data)) => {
      // persist context trhought pages
      context.current = data.current
      context.jokes = data.jokes
      Success(data)
    }
    | (Success(_), FetchJokes) => Loading
    | (Success(_), FetchSuccess(_))
    | (Loading, FetchJokes) => state
  }
