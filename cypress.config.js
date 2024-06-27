const { defineConfig } = require('cypress')

module.exports = defineConfig({
  e2e: {
    baseUrl: "http://localhost:5017",
    defaultCommandTimeout: 50000,
    supportFile: "cypress/support/index.js",
    specPattern: 'cypress/e2e/admin_registration_spec.js',
    specPattern: 'cypress/e2e/Failed_registration_spec.js',
  }
})
