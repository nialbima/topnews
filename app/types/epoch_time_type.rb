class EpochTimeType < ActiveRecord::Type::Value
  def type
    :epoch_time
  end

  def cast(value)
    return if value.blank?
    return value if value.is_a?(Time)

    Time.at(value)
  end
end
