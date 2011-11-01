# Provides custom serialization for ActiveRecord fields
class JsonCoder

  def load(data)
    JSON.parse(data) unless data.nil?
  end

  def dump(object)
    JSON.generate(object) unless object.nil?
  end

end