import json

type Message* = object
  username*: string
  message*: string

type MessageParsingError* = object of CatchableError

proc parseMessage*(data: string): Message =
  var data_json: JsonNode
  try:
    data_json = parseJson(data)
  except JsonParsingError:
    raise newException(MessageParsingError, "Invalid JSON: " &
                       getCurrentExceptionMsg())
  except:
    raise newException(MessageParsingError, "Unknown error: " &
                       getCurrentExceptionMsg())

  if not dataJson.hasKey("username"):
    raise newException(MessageParsingError, "Username field missing")

  result.username = dataJson["username"].getStr()
  if result.username.len == 0:
    raise newException(MessageParsingError, "Username field is empty")

  if not dataJson.hasKey("message"):
    raise newException(MessageParsingError, "Message field missing")
  result.message = dataJson["message"].getStr()
  if result.message.len == 0:
    raise newException(MessageParsingError, "Message field is empty")

  result.username = dataJson["username"].getStr()
  result.message = dataJson["message"].getStr()

proc createMessage*(username, message: string): string = 
  result = $(%{
    "username": %username,
    "message": %message
  }) & "\c\l"
when isMainModule:
  block:
    let data = """{"username": "John", "message": "Hi!"}"""
    let parsed = parseMessage(data)
    doAssert parsed.username == "John"
    doAssert parsed.message == "Hi!"

  block:
    let expected = """{"username":"dom","message":"hello"}""" & "\c\l"
    doAssert createMessage("dom", "hello") == expected
