class Components::View
  attr_reader :template, :assigns, :view
  
  def initialize(options = {})
    @view = ActionView::Base.new('app/views', {}, ActionController::Base.new)
    
    @assigns = options.fetch(:assigns, {})
  end
  
  def render(template, locals)
    view.render(partial: template, locals: assigns.merge(locals))
  end
end
