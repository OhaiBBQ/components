class Components::Renderer
  def initialize(options = {})
    @assigns = options[:assigns]
  end
  
  def render_html(body)
    components.inject(body) { |processed, renderer| renderer.process(processed) }.html_safe
  end

  def components
    Components.registered_components.map { |component| component.new(assigns) }
  end
  
  def assigns
    @assigns
  end
end
