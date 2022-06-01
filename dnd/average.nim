import strutils, strformat

proc mainLoop(av: float): void =
    var scores: array[6, int]
    var average: float

    echo("Input each ability score one-by-one")
    for i in 0..scores.len-1:
        var to_add_int: int
        try:
            to_add_int = parseInt(stdin.readLine())
        except:
            quit("You motherfucker. That isn't a number.")
        if to_add_int == 0:
            quit("Nice try, asshole. Zero ain't a valid number")
        scores[i] = to_add_int
    
    for i in 0..5:
        average += float(scores[i])

    average /= 6
    let pretty_out: string = scores.join(",")
    echo("Average of the default scores: ", av)
    echo(fmt"Average of your scores [{pretty_out}]: {average}")
    echo("Input anything to quit:")
    discard stdin.readLine()

var average: float
var total: float
var top: int = 4

for i in 1..top:
    total += float(i)

average += total / float(top)

top = 20
total = 0 
for i in 1..top:
    total += float(i)

average += total / float(top)

mainLoop(average)