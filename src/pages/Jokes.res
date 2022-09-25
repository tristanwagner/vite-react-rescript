@react.component
let make = (~path: string) => {
  let (state, send) = React.useReducer(JokesModule.reducer, Initial)

  let fetchJokes = () => {
    open Js.Promise
    send(FetchJokes)
    let _ = JokesModule.fetchJokes()|>then_(jokes => {
      let data: JokesModule.stateContext = {
        current: 0,
        jokes,
      }
      send(FetchSuccess(data))
      data->resolve
    })
  }

  <>
    <Nav url={path} />
    <h1>{"Jokes"->React.string}</h1>
    { switch state {
      | Initial => <button onClick={_ => fetchJokes()}> {"Fetch jokes"->React.string} </button>
      | Loading => <span> {"Loading jokes.."->React.string} </span>
      | Success(data) =>
        <div>
          <button onClick={_ => fetchJokes()}> {"Fetch new jokes"->React.string} </button>
          {
            data.jokes->
              Js.Array2.mapi((j, index) => <p>{ (string_of_int(index + 1) ++ ". " ++ j.setup ++ " => " ++ j.punchline)->React.string}</p>)
              ->React.array
          }
        </div>
    }}
  </>
}
