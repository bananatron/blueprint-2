class Builders::Base
  attr_reader :record, :errors

  def initialize(klass)
    @record = klass.new
    @record.instance_variable_set(:@builder, true)
    @errors = []
  end
end
