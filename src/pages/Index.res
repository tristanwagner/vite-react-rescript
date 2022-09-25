@module("./../logo.svg") external logo: string = "default"
%%raw(`import './Index.css'`)

@react.component
let make = (~path: string) => {
  let (count, setCount) = React.useState(() => 0)

  <>
    <Nav url={path} />
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p> {"Hello Vite + (P)React + ReScript!"->React.string} </p>
        <p>
          <button onClick={_e => setCount(count => count + 1)}>
            {`count is: ${count->Belt.Int.toString}`->React.string}
          </button>
        </p>
        <p>
          {"Edit "->React.string}
          <code> {"src/pages/Index.res"->React.string} </code>
          {" and save to test HMR updates."->React.string}
        </p>
        <textarea onInput={event => ReactEvent.Form.currentTarget(event)["value"]->Js.log}/>
        <p>
          <a
            className="App-link" href="https://reactjs.org" target="_blank" rel="noopener noreferrer">
            {"Learn React"->React.string}
          </a>
          {" | "->React.string}
          <a
            className="App-link"
            href="https://vitejs.dev/guide/features.html"
            target="_blank"
            rel="noopener noreferrer">
            {"Vite Docs"->React.string}
          </a>
          {" | "->React.string}
          <a
            className="App-link"
            href="https://rescript-lang.org/docs/react/latest/introduction"
            target="_blank"
            rel="noopener noreferrer">
            {"ReScript Docs"->React.string}
          </a>
        </p>
      </header>
    </div>
  </>
}
