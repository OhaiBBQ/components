require 'ostruct' 

class Components::View
  attr_reader :assigns, :view
  
  def initialize(options = {})
    @view = ComponentView.new('app/views', {}, ActionController::Base.new)
    
    @assigns = options.fetch(:assigns, {})
  end
  
  def render(template, locals)
    view.render(partial: template, locals: assigns.merge(locals))
  end

  # HACK
  class ComponentView < ActionView::Base
    include Rails.application.routes.url_helpers

    def optimize_routes_generation?
      true
    end

    def url_options
      {
        host: 'www.example.com'
      }
    end
  end
end
