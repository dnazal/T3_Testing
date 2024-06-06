# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/spec/'
  add_filter '/test/'
  add_filter '/config/'
  
  add_group 'Models', 'app/models'

end

require 'capybara/rspec'
require 'selenium-webdriver'

# Setting up Capybara to use Selenium with headless Chrome
Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')                 # Specify the headless argument
  options.add_argument('disable-gpu')              # GPU hardware acceleration isn't necessary for headless testing
  options.add_argument('no-sandbox')               # Bypass OS security model, necessary on certain platforms
  options.add_argument('disable-dev-shm-usage')    # Overcome limitations of Docker container in CI environments
  options.add_argument('window-size=1920x1080')    # Default window size for headless operation
  options.add_argument('--remote-debugging-port=9222') # Remote debugging port, useful for diagnosing issues
  
  # Make sure to set the correct path for the Chrome binary if not using the default location
  options.binary_location = '/usr/bin/google-chrome' 

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# Set the Capybara JavaScript driver
Capybara.javascript_driver = :headless_chrome

# RSpec configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    # This option will include chain clauses in custom matcher descriptions.
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Verifies that methods being mocked or stubbed are present on a real object
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Enables focusing on a specific test or group
  config.filter_run_when_matching :focus

  # Use this setting to specify where RSpec will save the status of examples
  config.example_status_persistence_file_path = 'spec/examples.txt'

  # Disables RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Enable warnings
  config.warnings = true

  # This setting is used to configure the default formatter before running the suite.
  config.default_formatter = 'doc' if config.files_to_run.one?

  # Run specs in random order to surface order dependencies
  config.order = :random

  

  # Seed global randomization in this process using the `--seed` CLI option.
  Kernel.srand config.seed


end
