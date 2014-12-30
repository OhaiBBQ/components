module Components
  def self.register(name, &block)
    component = Class.new(Components::Component)
    component.class_eval { component_name name }
    component.class_eval &block if block_given?

    self.registered_components << component
  end

  def self.registered_components
    @registered_components ||= []
  end
end

require_relative './components/component'
require_relative './components/local'
require_relative './components/processor'
require_relative './components/renderer'
