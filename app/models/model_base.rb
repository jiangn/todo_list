class ModelBase
  include ActiveModel::Serialization
  include ActiveModel::Validations

  attr_reader :id

  def serializable_hash
    hash = Hash.new
    instance_variables.each do |var|
      hash[var.to_s[1..-1]] = instance_variable_get(var)
    end
    hash
  end
end