// declared here to avoid circular dependency between Nav and RoutesModule
type route = {
  name: string,
  path: string,
  component: unit => React.element,
}
