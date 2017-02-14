class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :token,:type
end
