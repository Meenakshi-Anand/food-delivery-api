class ApplicationController < ActionController::API
 before_action :authenticate
 def logged_in?
   !!current_user
 end

 def current_user
   # if we find a jwt token in the header
   if auth_present?
     # find the user with the decoded id
     user = User.find(auth["user"])
     if user
       @current_user ||= user
     end
   end
 end

 def authenticate
   render json: {error: "unauthorized"}, status: 401 unless logged_in?
 end

 private

 def token
   request.env["HTTP_AUTHORIZATION"]
   .scan(/Bearer(.*)$/).flatten.last.strip
 end
 # returns the payload we created {user:1}
 def auth
   Auth.decode(token)
 end

 def auth_present?
   !!request.env.fetch("HTTP_AUTHORIZATION","")
   .scan(/Bearer/).flatten.first
 end

 end
