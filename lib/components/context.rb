# Components::Context gives application state to components through
# the `assigns` option & is able to render all registered components
# in to a string.

class Components::Context
  attr_reader :assigns, :registered_components

  def initialize(options = {})
    @assigns = options.fetch(:assigns, {})
    @view = options.fetch(:view) { Components::View.new(options) }
   
    @registered_components = options.fetch(:registered_components, Components.registered_components)
    @registered_components = @registered_components.map do |(component_name, component)|
      Components::Component.factory(component, @view)
    end
  end

  def render_html(body)
    registered_components.inject(body) do |memo, component|
      component.render_instances(memo)
    end
  end
end
