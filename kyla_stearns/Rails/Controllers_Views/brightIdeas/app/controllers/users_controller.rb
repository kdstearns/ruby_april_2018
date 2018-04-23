class UsersController < ApplicationController
	before_action :user_info, except: [:new, :create, :show]
	skip_before_action :require_login, only: [:new, :create]

	def create
	# submitted form to create new user 
		@user = User.create(user_params)
		if @user.valid?
			flash[:errors] = ["You have successfully registered, please login."]
			return redirect_to root_path
		end

		flash[:errors] = @user.errors.full_messages
		return redirect_to root_path

	end

	def show
	# render show page template
		@this_user = User.find_by(id: params[:id])
	end

	private
		def user_params
			params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
		end

		def user_info
			# p params[:id], "user_info with params[:id]"
			# p session[:id], "user_info with session[:id]"
			# params[:id] will be in string format, session[:id] will already be integer format
			unless params[:id].to_i == session[:id]
				flash[:errors] = ["You cannot access other users' information."]
  				return redirect_to user_path(session[:id])
  			end
		end

end