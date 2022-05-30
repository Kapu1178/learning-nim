import asyncdispatch, asyncnet

type Client = ref object
    socket: AsyncSocket
    net_addr: string
    id: int
    connected: bool

type Server = ref object
    socket: AsyncSocket
    clients: seq[Client]

proc newServer(): Server = Server(socket: newAsyncSocket(), clients: @[])


var server = newServer()