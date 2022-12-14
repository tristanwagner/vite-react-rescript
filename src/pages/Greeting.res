type person = Teacher | Director | Student(string)

let greeting = person =>
  switch person {
    | Teacher => "Hey teacher !"
    | Director => "Hello director !"
    | Student("Tristan") => "Is that you tristan ?"
    | Student(name) => "Oh hello there " ++ name ++ " !"
  }

@react.component
let make = () => {
  open Js.Array2
  let persons = [Student("Jim"), Teacher, Director, Student("Tristan")]
 <>
    { persons->map(p => <p>{greeting(p)->React.string}</p>)->React.array }
  </>
}
