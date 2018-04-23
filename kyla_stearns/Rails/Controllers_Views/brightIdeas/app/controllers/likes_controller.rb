class LikesController < ApplicationController

  def create
    # p params, "likes create params"
    @this_post = Post.find_by(id: params[:post_id])
    if @this_post.users_liked.include?(current_user)
      flash[:errors] = ["You cannot like a post more than once"]
      return redirect_to posts_path
    else
      @like_post = Like.create(user_id: session[:id], post_id: params[:post_id])
      if @like_post.valid?
        return redirect_to posts_path
      else
        flash[:errors] = @like_post.errors.full_messages
        return redirect_to posts_path
      end
    end
  end

  def destroy
  	# finds the like with the post id we passed and the current user
    # p params[:id], "likes destroy with params id (post_id)"
    # p session[:id], "likes destroy with session id"
  	@this_like = Like.find_by(post_id: params[:post_id], user_id: session[:id])
    if @this_like
  	  @this_like.destroy
  	  redirect_to posts_path
    else
      flash[:errors] = ["You cannot remove another user's like"]
      return redirect_to posts_path
    end
  end

end