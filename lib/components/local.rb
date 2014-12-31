class Components::Local
  attr_reader :name
  
  def initialize(name, options={})
    @name = name
    @local_regexp = /\{\{#{name} (.+?)}}/
    @options = options
  end

  def extract_match(text)
    value = Array(text.match(@local_regexp))[1]

    text.sub!(@local_regexp, '')
    
    value.nil? ? @options[:default] : value
  end
  
  def self.factory(hash)
    Components::Local.new(hash.fetch(:name), hash.fetch(:options, {}))
  end
end
