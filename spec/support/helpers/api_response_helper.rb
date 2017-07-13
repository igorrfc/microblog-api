module APIResponseHelper
  def hash_format_response
    JSON.parse(response.body).with_indifferent_access
  end
end
