import { newMockEvent } from "matchstick-as"
import { ethereum, BigInt, Address, Bytes } from "@graphprotocol/graph-ts"
import {
  listingBought,
  listingCreated
} from "../generated/Marketplace/Marketplace"

export function createlistingBoughtEvent(
  id: BigInt,
  buyer: Address,
  escrowContract: Address
): listingBought {
  let listingBoughtEvent = changetype<listingBought>(newMockEvent())

  listingBoughtEvent.parameters = new Array()

  listingBoughtEvent.parameters.push(
    new ethereum.EventParam("id", ethereum.Value.fromUnsignedBigInt(id))
  )
  listingBoughtEvent.parameters.push(
    new ethereum.EventParam("buyer", ethereum.Value.fromAddress(buyer))
  )
  listingBoughtEvent.parameters.push(
    new ethereum.EventParam(
      "escrowContract",
      ethereum.Value.fromAddress(escrowContract)
    )
  )

  return listingBoughtEvent
}

export function createlistingCreatedEvent(
  id: BigInt,
  picUrl: Bytes,
  owner: Address,
  description: string,
  price: BigInt
): listingCreated {
  let listingCreatedEvent = changetype<listingCreated>(newMockEvent())

  listingCreatedEvent.parameters = new Array()

  listingCreatedEvent.parameters.push(
    new ethereum.EventParam("id", ethereum.Value.fromUnsignedBigInt(id))
  )
  listingCreatedEvent.parameters.push(
    new ethereum.EventParam("picUrl", ethereum.Value.fromFixedBytes(picUrl))
  )
  listingCreatedEvent.parameters.push(
    new ethereum.EventParam("owner", ethereum.Value.fromAddress(owner))
  )
  listingCreatedEvent.parameters.push(
    new ethereum.EventParam(
      "description",
      ethereum.Value.fromString(description)
    )
  )
  listingCreatedEvent.parameters.push(
    new ethereum.EventParam("price", ethereum.Value.fromUnsignedBigInt(price))
  )

  return listingCreatedEvent
}
