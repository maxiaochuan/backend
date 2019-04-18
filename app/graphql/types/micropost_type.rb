module Types
  class MicropostType < Types::BaseObject
    field :id, ID, null: false
    field :content, String, null: true
    field :user, [Types::UserType], null: true
  end
end
