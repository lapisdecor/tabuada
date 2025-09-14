# This is just a simple terminal game to test
# your multiplication tables knowledge

import std/random, std/strformat, std/strbasics

proc start =
  # TODO read hi-score file
  #
  var points: int = 0
  var level: int = 1
  var stopGame: bool = false
  var firstVal: int = 2
  var lastVal: int = 9
  var fails = 0
  var hiName = "Antrok"
  var hiScore: int = 50

  echo("Type q to quit.")
  while stopGame == false:

    randomize()
    echo("\n")
    echo("LEVEL {level}".fmt)
    echo("\n")
    for n in 1..10:
      var a = rand(firstVal..lastVal)
      var b = rand(firstVal..lastVal)
      var c  = a * b
      var d = $c
      echo("{a} x {b} = ?".fmt)
      var consoleInput = readLine(stdin)
      strip(consoleInput)
      if consoleInput == "q":
        echo("Bye!\n".fmt)
        stopGame = true
        break
      if consoleInput == d:
        echo("Correct!\n😀\n".fmt)
        points += 10
      else:
        echo("Incorrect. It was {d}.\n".fmt)
        fails += 1
      if fails == 3:
        echo("You failed 3 times.")
        echo("GAME OVER")
        stopGame = true
        break
    level += 1
    lastVal += 2

  echo("You got {points} points!\n".fmt)

  if points > hiScore:
    echo("Enter your name")
    var consoleInput = readLine(stdin)
    strip(consoleInput)
    hiName = consoleInput
    hiScore = points
  # TODO write to hi-score file


  # TODO print high score
  echo("Best points by {hiName} with {hiScore} points!".fmt)


when isMainModule:
  start()
