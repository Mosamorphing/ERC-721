const { buildModule } = require("@nomicfoundation/hardhat-ignition");

module.exports = buildModule("EdenModule", (m) => {
  const eden = m.contract("Eden");
  return { eden };
});