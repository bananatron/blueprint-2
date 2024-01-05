# NOTE: Not only are broadcasts happening on create/update,
# but on subscribe, the broadcast_schema methods are manually called
# so when they're update anywhere, ensure to check both places

module CableBroadcastable
  extend ActiveSupport::Concern

  included do
    after_commit :broadcast, on: [:create, :update], if: :any_changes?
    after_destroy :broadcast
  end

  def broadcast
    bc = broadcast_schema

    raise "No channels to broadcast" if bc.nil?
    raise "broadcast_schema should be an Array, got: #{bc.class}" unless bc.is_a?(Array)
    return if bc.empty?

    bc.each do |schema|
      raise "schema should be a Hash, got: #{schema.class}" unless schema.is_a?(Hash)
      raise "Missing channel or data for broadcast_schema: #{schema}" unless schema[:channel] && schema[:data]

      ActionCable.server.broadcast(schema[:channel], Oj.dump(schema[:data]))
    end
  end

  def object_serialize
    raise NotImplementedError
  end

  def broadcast_schema
    raise NotImplementedError
  end
end
