class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :tagline, :description

  def id
    object.token
  end

  def name
    object.name
  end

  def email
    object.user.email
  end
end

