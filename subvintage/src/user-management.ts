import { userCreated as userCreatedEvent } from "../generated/UserManagement/UserManagement"
import { userCreated } from "../generated/schema"

export function handleuserCreated(event: userCreatedEvent): void {
  let entity = new userCreated(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.UserManagement_id = event.params.id
  entity.username = event.params.username

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}
