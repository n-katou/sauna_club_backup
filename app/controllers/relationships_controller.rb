class RelationshipsController < ApplicationController
  #フォローする時
  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end

  #フォローはずす時
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings.order("created_at DESC").page(params[:page]).per(5)
  end

  #　フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end
end
