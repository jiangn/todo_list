class User < ModelBase
  attr_reader :email, :api_token

  def initialize(attribs={})
    @id = attribs['id']
    @email = attribs['email']
    @api_token = attribs['api_token']
  end
end
