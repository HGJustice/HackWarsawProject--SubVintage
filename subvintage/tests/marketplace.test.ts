import {
  assert,
  describe,
  test,
  clearStore,
  beforeAll,
  afterAll
} from "matchstick-as/assembly/index"
import { BigInt, Address } from "@graphprotocol/graph-ts"
import { listingBought } from "../generated/schema"
import { listingBought as listingBoughtEvent } from "../generated/Marketplace/Marketplace"
import { handlelistingBought } from "../src/marketplace"
import { createlistingBoughtEvent } from "./marketplace-utils"

// Tests structure (matchstick-as >=0.5.0)
// https://thegraph.com/docs/en/developer/matchstick/#tests-structure-0-5-0

describe("Describe entity assertions", () => {
  beforeAll(() => {
    let id = BigInt.fromI32(234)
    let buyer = Address.fromString("0x0000000000000000000000000000000000000001")
    let escrowContract = Address.fromString(
      "0x0000000000000000000000000000000000000001"
    )
    let newlistingBoughtEvent = createlistingBoughtEvent(
      id,
      buyer,
      escrowContract
    )
    handlelistingBought(newlistingBoughtEvent)
  })

  afterAll(() => {
    clearStore()
  })

  // For more test scenarios, see:
  // https://thegraph.com/docs/en/developer/matchstick/#write-a-unit-test

  test("listingBought created and stored", () => {
    assert.entityCount("listingBought", 1)

    // 0xa16081f360e3847006db660bae1c6d1b2e17ec2a is the default address used in newMockEvent() function
    assert.fieldEquals(
      "listingBought",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "buyer",
      "0x0000000000000000000000000000000000000001"
    )
    assert.fieldEquals(
      "listingBought",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "escrowContract",
      "0x0000000000000000000000000000000000000001"
    )

    // More assert options:
    // https://thegraph.com/docs/en/developer/matchstick/#asserts
  })
})
