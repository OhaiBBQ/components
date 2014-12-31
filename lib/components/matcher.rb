class Components::Matcher
  def initialize(name)
    @name = name
  end

  def process(text, &block)
    text.gsub(component_regexp) do |match|
      block.call(remove_tags(match))
    end
  end

  private

  def remove_tags(text)
    text.sub(component_start, '')
      .sub(component_end,   '')
  end

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
end
