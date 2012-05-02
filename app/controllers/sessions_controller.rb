class SessionsController < ApplicationController
	def create
		auth = request.env["omniauth.auth"]
		email = auth["uid"]
		if email.end_with?('olin.edu')
			user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
			session[:user_id] = user.id
			redirect_to root_url, :notice => "Signed in!"
		else
			redirect_to root_url, :notice => "Only users with email addresses ending in olin.edu are allowed."
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Signed out!"
	end
end
