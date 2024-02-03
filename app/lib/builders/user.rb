class Builders::User < Builders::Base
  def initialize
    super(User)
  end

  def build(
    name:,
    email: nil,
    password: nil,
    super_user: false
  )

    default_pass = SecureRandom.hex(16)
    @record.name = name
    @record.email = email
    @record.password = default_pass
    @record.password_confirmation = default_pass
    @record.super = super_user

    unless @record.valid?
      @errors += @record.errors.full_messages
      return false
    end

    begin
      ActiveRecord::Base.transaction do
        @record.save!

        character_builder = Builders::Character.new
        if character_builder.build(name: name, user: @record)
          @record.current_character_id = character_builder.record.id
        else
          @errors += character_builder.errors
          raise ActiveRecord::Rollback
        end
      end
    rescue ActiveRecord::RecordInvalid => error
      @errors << error.message
      false
    end
  end
end
