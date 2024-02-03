module HasBuilder
  extend ActiveSupport::Concern

  included do
    before_create :prevent_create_unless_builder
  end

  def prevent_create_unless_builder
    unless instance_variable_get(:@builder)
      errors.add(:base, "Record can only be created by a builder")
      throw(:abort)
    end
  end
end
