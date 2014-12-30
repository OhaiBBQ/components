class Components::Local
  def initialize(name, options={})
    @local_regexp = /\{\{#{name} (.+?)}}/
    @options = options
  end

  def value_from(text)
    value = Array(text.match(@local_regexp))[1]

    value.present? ? value.html_safe : @options[:default]
  end

  def to_regexp
    @local_regexp
  end
end
