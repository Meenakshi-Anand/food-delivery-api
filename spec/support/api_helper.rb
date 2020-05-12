module ApiHelper
  def authenticated_header(request, user)
    token = Auth.issue({ user: user.id })
    request.headers.merge!('Authorization': "Bearer #{token}")
  end
end
