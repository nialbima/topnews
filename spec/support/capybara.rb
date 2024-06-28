require "capybara/rails"
require "capybara/rspec"
require "capybara/cuprite"

Capybara.register_driver(:custom_cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, inspector: ENV["INSPECTOR"], window_size: [1200, 800])
end

Capybara.default_driver = Capybara.javascript_driver = :custom_cuprite

RSpec.configure do |config|
  config.prepend_before(:each, type: :system) do
    driven_by Capybara.javascript_driver
  end
end
