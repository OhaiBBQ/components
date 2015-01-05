class Components::Patterns
  Instance = Struct.new(:body, :inline_locals)  
  def initialize(name)
    @name = name
  end
  
  def find_instances(text, &block) 
    process_occurrences(text, component_regexp, &block)
    process_occurrences(text, component_self_close_regexp, &block)
  end
  
  private
  def process_occurrences(text, pattern, &block)
    while match = pattern.match(text)
      text.sub!(pattern, '')

      body = match.names.include?('component_body') ? match['component_body'] : ''
      
      block.call Instance.new(body.html_safe, match['locals'])
    end
  end
  
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
   
  def component_self_close_regexp
    /{{##{@name}#{Components::Local::INLINE_REGEXP}[ ]{0,1}\/}}/
  end
end
