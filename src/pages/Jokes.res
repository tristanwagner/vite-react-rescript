@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(JokesModule.reducer, Success(JokesModule.context))

  let fetchJokes = () => {
    open Promise
    dispatch(FetchJokes)
    let _ = JokesModule.fetchJokes()
      ->then(jokes => {
        let data: JokesModule.stateContext = { current: 0, jokes }
        dispatch(FetchSuccess(data))
        data->resolve
      })
  }

  <>
    <h1>{"Jokes"->React.string}</h1>
    <button onClick={_ => fetchJokes()}> {"Fetch jokes"->React.string} </button>
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
