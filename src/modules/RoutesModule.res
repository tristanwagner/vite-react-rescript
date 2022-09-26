open Global

// Auto generates routes from files under ./pages
// https://vitejs.dev/guide/features.html#glob-import
let pages = %raw(`import.meta.glob("../pages/*.bs.js", { eager: true })`)

let routes = Js.Dict.keys(pages)->Js.Array2.map(path => {
  let name =
    path
    ->Js.String2.match_(%re("/\.\/pages\/(.*)\.bs\.js$/"))
    ->Belt.Option.getExn
    ->Js.Array2.unsafe_get(1)
    ->Belt.Option.getExn
  {
    name: name,
    path: name === "Index" ? "/" : `/${name->Js.String2.toLowerCase}`,
    component: Js.Dict.unsafeGet(pages, path)["make"],
  }
})

let rec formatPathname = (path: list<string>) =>
  switch path {
      | list{} => "/"
      | list{a, ...rest} => "/" ++ a ++ (rest->List.length > 0 ? formatPathname(rest) : "")
    }

let makeRoute = (pathname) => (component) => <><Nav routes={routes} url={pathname}/>{ component }</>
