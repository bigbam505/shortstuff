class ShortUrl
  attr_reader :url, :name

  def initialize(options)
    if options[:name].present?
      @name = options[:name]
    else
      @name = generate_random_name
    end

    @url = options[:url]
  end

  def save
    unless existing_entry_with_same_name?
      create_entry
    end
  end

  def full_url
    "http://#{HOSTNAME}/#{name}"
  end

  private

  def existing_entry_with_same_name?
    entry_exists_with_name?(@name)
  end

  def entry_exists_with_name?(name)
    redis.exists(name)
  end

  def create_entry
    redis.set(@name, @url)
  end

  def generate_random_name
    name = NameGenerator.generate

    while entry_exists_with_name?(name)
      name = NameGenerator.generate
    end

    name
  end

  def redis
    @redis ||= Redis.new(:driver => :hiredis)
  end
end
