import std/strformat

var mylist = newSeq[string] (3)
mylist[0] = "Foo"
mylist[1] = "Bar"
mylist[2] = "Baz"

mylist.add("Lorem")

proc printList(list : seq) = 
    if list.len == 0:
        echo($list[0])
        return

    var val = $list[0]
    for item in 1 .. list.len-1:
        val &= fmt", {list[item]}"
    echo(val)

printList(mylist)