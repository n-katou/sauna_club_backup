class CommentsController < ApplicationController
  def edit
  end

  def create
    post = Post.find(params[:post_id])
    comment = current_customer.posts.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post.id)
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end

end
