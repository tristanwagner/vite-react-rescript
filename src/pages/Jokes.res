@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(JokesModule.reducer, Success(JokesModule.context))

  let fetchJokes = async () => {
    dispatch(FetchJokes)
    let jokes = await JokesModule.fetchJokes()
    dispatch(FetchSuccess({ current: 0, jokes }))
  }

  <>
    <h1>{"Jokes"->React.string}</h1>
    <button onClick={_ => fetchJokes()->ignore}> {"Fetch jokes"->React.string} </button>
    { switch state {
      | Loading => <p> {"Loading jokes.."->React.string} </p>
      | Success(data) =>
        <div>
          {
            data.jokes->
              Array.mapWithIndex((j, index) => <p>{ (string_of_int(index + 1) ++ ". " ++ j.setup ++ " => " ++ j.punchline)->React.string}</p>)
              ->React.array
          }
        </div>
    }}
  </>
}
