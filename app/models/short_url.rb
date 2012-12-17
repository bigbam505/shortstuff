class ShortUrl
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  attr_reader :url, :name

  validate :name_must_be_unique
  validates :url, format: { with: (/^http(s)?:\/\//), message: "must start with http(s)://" }

  def initialize(options = {})
    if options[:name].present?
      @name = options[:name]
    else
      @name = generate_random_name
    end

    @url = options[:url]
  end

  def save
    if valid?
      create_entry
    end
  end

  def self.find_by_name(name)
    stored_url = redis.get(name)
    if stored_url
      ShortUrl.new(name: name, url: stored_url)
    end
  end

  def full_url
    "http://#{HOSTNAME}/#{name}"
  end

  def as_json(options = {})
    { full_url: full_url }.merge(super)
  end

  private

  def name_must_be_unique
    if existing_entry_with_same_name?
      errors.add(:name, "a link already exists named #{name}")
    end
  end

  def persisted?
    false
  end

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

  def self.redis
    @redis ||= Redis.new(:driver => :hiredis)
  end
end
