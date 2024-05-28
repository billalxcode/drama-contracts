import { buildModule } from "@nomicfoundation/hardhat-ignition/modules"

const Drama = buildModule("Drama", (module) => {
    const dramaContract = module.contract("Drama")

    return { dramaContract }
})

export default Drama