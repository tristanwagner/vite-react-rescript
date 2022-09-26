%%raw(`import './App.css'`)

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let pathname = RoutesModule.formatPathname(url.path)
  let makeRoute = RoutesModule.makeRoute(pathname)

  switch url.path {
    | list{} => makeRoute(<Index />)
    | list{"test"} => makeRoute(<Test />)
    | list{"test", id} => makeRoute(<Test id />)
    | list{"greeting"} => makeRoute(<Greeting />)
    | list{"fizzbuzz"} => makeRoute(<FizzBuzz />)
    | list{"jokes"} => makeRoute(<Jokes />)
    | list{"toggle"} => makeRoute(<Toggle />)
    | _ => <span>{"Not found"->React.string}</span>
  }
}
