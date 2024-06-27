require "rails_helper"

RSpec.describe EpochTimeType do
  include ActiveSupport::Testing::TimeHelpers

  it "casts an integer to a Time object" do
    freeze_time do
      time = Time.now
      epoch_time = time.to_i

      expect(EpochTimeType.new.cast(epoch_time)).to eq(time)
    end
  end
end
