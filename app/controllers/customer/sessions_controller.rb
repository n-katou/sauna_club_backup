# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  before_action :reject_inactive_customer, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def new_guest
    customer = Customer.guest
    sign_in customer   # ユーザーをログインさせる
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def reject_inactive_customer #退会メソッド
      @customer = Customer.find_by(email: params[:customer][:email])
      # return if !@customer
      if @customer.valid_password?(params[:customer][:password])
        if @customer.is_active == true
        else
          redirect_to new_customer_registration_path
        end
      end
  end

end
