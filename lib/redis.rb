require "redis"
require "connection_pool"

$redis = ConnectionPool::Wrapper.new(size: 5, timeout: 3) {
  Redis.new(Rails.application.config_for(:redis))
}
