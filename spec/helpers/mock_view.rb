class MockView
  attr_reader :render_calls
  
  def initialize
    @render_calls = []
  end
  
  def last_render_call
    render_calls.last  
  end
  
  def render(template, locals)
    render_calls.push({ template: template, locals: locals})
    
    "#{template} (call number #{render_calls.size})"
  end
end
