class Components::Component
  class << self
    def component_locals
      @component_locals ||= {}
    end

    def accepts_local(name, options = {})
      component_locals[name] = Components::Local.new(name, options)
    end

    def component_name(name)
      @name = name
    end
    
    def name
      @name
    end
  end
  
  def initialize(options = {})
    @options = options
  end

  def process(text)
    Components::Processor.new(name, template, component_locals).process(text, assigns)
  end

  protected

  def template
    "shared/#{name}"
  end
  
  def name
    self.class.name
  end
  
  def component_locals
    self.class.component_locals
  end
  
  def assigns
    @options
  end
end

