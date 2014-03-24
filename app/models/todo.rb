class Todo < ModelBase
  attr_accessor :description, :is_complete, :order

  def initialize(attribs={})
    @id = attribs['id']
    @description = attribs['description']
    @is_complete = attribs['is_complete'] == 'true' || attribs['is_complete'] == true
    @order = attribs['order'].nil? ? nil : attribs['order']
  end
end