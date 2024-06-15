import {
  assert,
  describe,
  test,
  clearStore,
  beforeAll,
  afterAll
} from "matchstick-as/assembly/index"
import { BigInt } from "@graphprotocol/graph-ts"
import { userCreated } from "../generated/schema"
import { userCreated as userCreatedEvent } from "../generated/UserManagement/UserManagement"
import { handleuserCreated } from "../src/user-management"
import { createuserCreatedEvent } from "./user-management-utils"

// Tests structure (matchstick-as >=0.5.0)
// https://thegraph.com/docs/en/developer/matchstick/#tests-structure-0-5-0

describe("Describe entity assertions", () => {
  beforeAll(() => {
    let id = BigInt.fromI32(234)
    let username = "Example string value"
    let newuserCreatedEvent = createuserCreatedEvent(id, username)
    handleuserCreated(newuserCreatedEvent)
  })

  afterAll(() => {
    clearStore()
  })

  // For more test scenarios, see:
  // https://thegraph.com/docs/en/developer/matchstick/#write-a-unit-test

  test("userCreated created and stored", () => {
    assert.entityCount("userCreated", 1)

    // 0xa16081f360e3847006db660bae1c6d1b2e17ec2a is the default address used in newMockEvent() function
    assert.fieldEquals(
      "userCreated",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "username",
      "Example string value"
    )

    // More assert options:
    // https://thegraph.com/docs/en/developer/matchstick/#asserts
  })
})
