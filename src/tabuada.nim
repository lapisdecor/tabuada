# This is just a simple terminal game to test
# your multiplication tables knowledge

import std/random, std/strformat, std/strbasics

proc start = 
  echo("Type q to quit.")
  while true:
    randomize()
    var a = rand(2..9)
    var b = rand(2..9)
    var c  = a * b
    var d = $c   
    echo("{a} x {b} = ?".fmt)
    var consoleInput = readLine(stdin)
    strip(consoleInput)
    if consoleInput == "q":
      echo("Bye!\n".fmt)
      break
    if consoleInput == d:
      echo("Correct!\n".fmt)
    else:
      echo("Incorrect. It was {d}.".fmt)

    echo("\n")

  
when isMainModule:
  start()
