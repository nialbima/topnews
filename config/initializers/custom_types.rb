# This threw load order errors, so I'm just requiring it explicitly.
require_relative "../../app/types/array_of_integers_type"
require_relative "../../app/types/epoch_time_type"

ActiveModel::Type.register(:array_of_integers, ArrayOfIntegersType)
ActiveModel::Type.register(:epoch_time, EpochTimeType)
