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
  <>
    <p>{greeting(Student("Jim"))->React.string}</p>
    <p>{greeting(Teacher)->React.string}</p>
    <p>{greeting(Student("Tristan"))->React.string}</p>
    <p>{greeting(Director)->React.string}</p>
  </>
}
