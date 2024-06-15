import {
  listingBought as listingBoughtEvent,
  listingCreated as listingCreatedEvent,
} from "../generated/Marketplace/Marketplace"
import { listingBought, listingCreated } from "../generated/schema"

export function handlelistingBought(event: listingBoughtEvent): void {
  let entity = new listingBought(
    event.transaction.hash.concatI32(event.logIndex.toI32()),
  )
  entity.Marketplace_id = event.params.id
  entity.buyer = event.params.buyer
  entity.escrowContract = event.params.escrowContract

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlelistingCreated(event: listingCreatedEvent): void {
  let entity = new listingCreated(
    event.transaction.hash.concatI32(event.logIndex.toI32()),
  )
  entity.Marketplace_id = event.params.id
  entity.owner = event.params.owner
  entity.description = event.params.description
  entity.price = event.params.price

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}
