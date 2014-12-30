class Components::Processor
  def initialize(name, template, locals)
    @name = name
    @template = template
    @locals = locals
  end
    
  def process(text, assigns)
    view = ActionView::Base.new('app/views', {}, ActionController::Base.new)
    
    text.gsub(component_regexp) do |match|
      view.render(partial: @template,
                  locals: locals_for(match)
                            .merge(assigns)
                            .merge(content: match.sub(component_start, '')
                                                 .sub(component_end,   '')))
    end
  end

  private 
  def component_start
    /{{##{@name}}}/
  end
  
  def component_body
    /([\s\S]+?)/
  end
  
  def component_end
    /{{\/#{@name}}}/
  end
  
  def component_regexp
    /#{component_start}#{component_body}#{component_end}/
  end
  
  def locals_for(match)
    @locals.inject({}) do |locals, (key, local)|
      locals[key] = local.value_from(match)

      match.sub!(local.to_regexp, '')

      locals
    end
  end
end
