# frozen_string_literal: true

class UserSerializer
  def self.as_json(resource)
    if resource.respond_to?(:to_ary)
      resource.map { |user| serialize(user) }
    else
      serialize(resource)
    end
  end

  private

  def self.serialize(user)
    {
      id: user.id,
      name: user.name,
      surname: user.surname,
      email: user.email,
      username: user.username,
      role: user.role
    }
  end

end
