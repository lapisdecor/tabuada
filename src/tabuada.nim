# This is just a simple terminal game to test
# your multiplication tables knowledge

import std/random, std/strformat, std/strbasics, std/files, std/paths, std/strutils, std/os

proc chooseWords(answerType: string): string =
  let good = @["Very well!", "Bravo!", "Thats it!", "Awsome!", "Amazing!"]
  let bad = @["Sorry.", "Next time will be better.", "Think a bit harder.", "Bad luck...", "Don't give up!"]
  var words = ""
  let i = rand(0..2)
  if answerType == "good":
    words = good[i]
  else:
    words = bad[i]
  return words

proc start =
  var points: int = 0
  var level: int = 1
  var stopGame: bool = false
  var firstVal: int = 2
  var lastVal: int = 9
  var fails = 0
  var hiName = "Antrok"
  var hiScore: int = 20
  var filename = "highscore.txt"
  var content = hiName & "," &  $hiScore
  let snapUserData = getEnv("SNAP_USER_DATA")
  var pathToFile: Path

  if snapUserData == "":
    # We are not in a snap
    pathToFile = filename.Path
    if fileExists(pathToFile):
      content = readFile(filename)
  else:
    pathToFile = snapUserData.Path / filename.Path
    if fileExists(pathToFile):
      content = readFile(pathToFile.string)

  var splited = content.split(',')
  hiName = splited[0]
  hiScore = splited[1].parseInt




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
        echo("Correct!\n😀".fmt)
        echo(chooseWords("good") & "\n")
        points += 10
      else:
        echo("Incorrect. It was {d}.\n😵".fmt)
        echo(chooseWords("bad") & "\n")
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
    var textToWrite = hiName & "," & $hiScore
    # write to hi-score file
    writeFile(pathToFile.string, textToWrite)


  # TODO print high score
  echo("Best points by {hiName} with {hiScore} points!".fmt)


when isMainModule:
  start()
