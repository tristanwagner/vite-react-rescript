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

  let joke = object(field => {
    id: field.required("id", int),
    setup: field.required("setup", string),
    punchline: field.required("punchline", string),
  })

  let jokes = (json) => json->decode(array(joke))->Result.getExn
}

let fetchJokes = async () => {
  open Fetch
  let res = await get("https://official-joke-api.appspot.com/jokes/programming/ten")
  await res->Response.json
}

let getJokes = async () => {
  (await fetchJokes())->Decode.jokes
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
