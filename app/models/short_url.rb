class ShortUrl
  attr_reader :url, :name

  def initialize(options)
    @name = options[:name]
    @url = options[:url]
  end

  def save
    unless existing_entry_with_same_name?
      create_entry
    end
  end

  private

  def existing_entry_with_same_name?
    redis.exists(@name)
  end

  def redis
    @redis ||= Redis.new(:driver => :hiredis)
  end

  def create_entry
    redis.set(@name, @url)
  end
end
