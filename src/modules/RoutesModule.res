type route = {
  name: string,
  path: string,
  component: unit => React.element,
}

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

// TODO: remove
pages->Js.log
routes->Js.log

let makeRouteComponent = ({path, component: routeComp}: route) => {
  module T = {
    let makeProps: (
      ~key: string,
      ~path: string,
      unit,
    ) => unit = %raw(`function (prim0, prim1, prim2) {
      var tmp = {};
      if (prim0 !== undefined) {
        tmp.key = prim0;
      }
      if (prim1 !== undefined) {
        tmp.path = prim1;
      }
      if (prim2 !== undefined) {
        tmp.children = prim2;
      }
      console.log("router route rendered", tmp)
      return tmp;
    }`)
    let make = routeComp
  }

  <T key={path} path={path} />
}

let getRoutesComponents = () => routes->Js.Array2.map(makeRouteComponent)->React.array
