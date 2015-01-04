class Components::Patterns
  Instance = Struct.new(:body, :inline_locals)  
  def initialize(name)
    @name = name
  end
  
  def find_instances(text, &block)
    while match = component_regexp.match(text)
      text.sub!(component_regexp, '')

      block.call Instance.new(match['component_body'].html_safe, match['locals'])
   end
  end
  
  private
  def component_start
    /{{##{@name}#{Components::Local::INLINE_REGEXP}}}/
  end

  def component_body
    /(?<component_body>[\s\S]+?)/
  end

  def component_end
    /{{\/#{@name}}}/
  end

  def component_regexp
    /#{component_start}#{component_body}#{component_end}/
  end
end
