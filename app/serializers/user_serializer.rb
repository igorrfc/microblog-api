# UserSerializer - prepares the JSON format of the user resource for API's responses
class UserSerializer
  def self.serialize(resource)
    resource.as_json(except: :password_digest, include: %i[posts followers followees notifications])
  end
end
