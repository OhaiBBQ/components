require_relative './mock_view'
require_relative '../../lib/components'

# Monkey patch so we don't need to load rails

class String
  def html_safe
    to_s
  end
end

class Object
  def blank?
    nil? || to_s == ""
  end
end
