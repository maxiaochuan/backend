module Types
  class UserType < BaseTimestampsObject
    field :name, String, null: false
    field :email, String, null: false
  end
end
