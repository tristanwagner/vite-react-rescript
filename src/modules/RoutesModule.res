open Global

// Auto generates routes from files under ./pages
// https://vitejs.dev/guide/features.html#glob-import
let pages = %raw(`import.meta.glob("../pages/*.bs.js", { eager: true })`)

let routes = Object.keysToArray(pages)->Array.map(path => {
  let name =
    path
    ->String.match(%re("/\.\/pages\/(.*)\.bs\.js$/"))
    ->Option.getExn
    ->Array.get(1)
    ->Option.getExn

  let component = switch (Object.get(pages, path)){
    | Some(component) => component["make"]
    | None => () => <>{"Not found"->React.string}</>
  }

  {
    name: name,
    path: name === "Index" ? "/" : `/${name->String.toLowerCase}`,
    component: component
  }
})

let rec formatPathname = (path: list<string>) =>
  switch path {
      | list{} => "/"
      | list{a, ...rest} => "/" ++ a ++ (rest->List.length > 0 ? formatPathname(rest) : "")
    }

let makeRoute = (pathname) => (component) => <><Nav routes={routes} url={pathname}/>{ component }</>
