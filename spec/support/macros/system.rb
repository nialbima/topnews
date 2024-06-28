module Macros
  module System
    def pause_and_debug
      page.driver.debug(binding)
    end
  end
end
