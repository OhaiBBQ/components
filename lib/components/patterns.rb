class Components::Patterns
  Instance = Struct.new(:body, :inline_locals)

  def initialize(name)
    @name = name
  end

  def find_instances(source, &content_generator)
    process_occurrences(source, component_regexp, &content_generator)
    process_occurrences(source, component_self_close_regexp, &content_generator)
  end

  private
  def process_occurrences(source, component_pattern, &content_generator)
    while component_match = component_pattern.match(source)
      body = component_match.names.include?('component_body') ? component_match['component_body'] : ''
      
      instance = Instance.new(body.html_safe,
                              component_match['locals'])

      source.sub!(component_pattern,
                content_generator.call(instance))
    end

    source
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
