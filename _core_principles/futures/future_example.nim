import asyncfutures

var myfuture = newFuture[int]()
doAssert(not myfuture.finished)
myfuture.addCallback(
    proc(future: Future[int]) = 
        echo("Future is no longer empty, ", future.read)
)
myfuture.complete(42)
#[OUT:
Future is no longer empty, 42
]#