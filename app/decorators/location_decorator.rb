class LocationDecorator
  attr_reader :object

  delegate_missing_to :object

  def initialize(object)
    @object = object
  end


end