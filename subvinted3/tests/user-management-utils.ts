import { newMockEvent } from "matchstick-as"
import { ethereum, BigInt } from "@graphprotocol/graph-ts"
import { userCreated } from "../generated/UserManagement/UserManagement"

export function createuserCreatedEvent(
  id: BigInt,
  username: string
): userCreated {
  let userCreatedEvent = changetype<userCreated>(newMockEvent())

  userCreatedEvent.parameters = new Array()

  userCreatedEvent.parameters.push(
    new ethereum.EventParam("id", ethereum.Value.fromUnsignedBigInt(id))
  )
  userCreatedEvent.parameters.push(
    new ethereum.EventParam("username", ethereum.Value.fromString(username))
  )

  return userCreatedEvent
}
