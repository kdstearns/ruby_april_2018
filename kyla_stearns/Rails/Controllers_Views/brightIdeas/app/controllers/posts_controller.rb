class PostsController < ApplicationController
	def index
		# THIS DOESN'T ALLOW FOR SORTING -- WILL HAVE TO CREATE EXTRA COLUMN FOR THAT
		@posts = Post.all.eager_load(:user, :users_liked)
		# USES 22 QUERIES @posts = Post.joins('left join likes on likes.post_id = posts.id').group(:id).order('count(likes.id) desc').preload(:likes)
		# MESSES W/ ABILITY TO LOOP THROUGH IN HTML @posts = Post.includes(:likes).group(:id, likes: :id).order('count(likes.id) desc').references(:likes)
		
	end

	def create
		p params
		@post = Post.create(content: params[:post][:content], user_id: session[:id])
		# @post = Post.create(post_params)
		if @post.valid?
			return redirect_to posts_path
		end

		flash[:errors] = @post.errors.full_messages
		return redirect_to posts_path
	end

	def show
		@this_post = Post.find_by(id: params[:id])
		# @this_post = Post.eager_load(:user, :users_liked).where(id: params[:id])
		# @this_post = User.find_by(posts_liked: params[:id])
	end

	def destroy
		@this_post = Post.find_by(id: params[:id])
		if current_user == @this_post.user
		# p @this_post, "INSIDE DESTROY METHOD WITH post"
			@this_post.destroy
			return redirect_to posts_path
		else
			flash[:errors] = ["That is not your post to destroy."]
			return redirect_to posts_path
		end
	end

	# private
	# 	def post_params
	# 		params.require(:post).permit(:content, :user_id)
	# 	end
end
