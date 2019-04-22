module Mutations
  class CreateUser < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true
    argument :email, String, required: true

    # return type from the mutation
    type Types::UserType

    def resolve(name: nil, email: nil)
      User.create!(
        name: name,
        email: email,
      )
    end
  end
end