class Components::Local
  LOCAL_NAME_REGEXP = /.+/
  QOUTED_CONTENT_REGEXP = /"(?<local_value>[\s\S]+?)"/
  INLINE_REGEXP = /(?<locals> (#{LOCAL_NAME_REGEXP}=#{QOUTED_CONTENT_REGEXP})?)/
  
  attr_reader :name
  
  def initialize(name, options={})
    @name = name
    @local_regexp = /\{\{#{name} (?<local_value>.+)}}/
    @options = options
  end
  
  def extract_from(instance)
    local = extract_local(instance.body, @local_regexp)

    local.blank? ? extract_local(instance.inline_locals, inline_local_regexp) : local
  end

  private
  
  def extract_local(text, regexp)
    match = text.match(regexp)
    
    text.sub!(regexp, '')

    default(match) { match['local_value'] }
  end
  
  def default(value, &presence_block)
    value = value.blank? ? @options[:default] : presence_block.call

    value.to_s.html_safe
  end
  
  def inline_local_regexp
    /#{name}=#{QOUTED_CONTENT_REGEXP}\s{0,1}/
  end
  
  def self.factory(hash)
    Components::Local.new(hash.fetch(:name), hash)
  end
end
