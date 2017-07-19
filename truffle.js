
module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*' // Match any network id
    },
    integration: {
      host: '10.1.225.121',
      port: 8545,
      network_id: '*' // Match any network id
    }
  }
}
