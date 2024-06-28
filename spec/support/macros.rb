module Macros
  def load_all(rspec_config_object)
    load_system_macros(rspec_config_object)
  end

  module_function :load_all

  def load_system_macros(rspec_config_object)
    rspec_config_object.include Macros::System, type: :system
  end

  module_function :load_system_macros
end
