# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :ensure_guest_member, only: [:edit]

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

  # ゲストログイン
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to about_path, notice: 'ゲストとしてログインしました'
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:])
  # end

  def after_sign_in_path_for(resource)
    member_path(current_member)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private 
  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.nickname == "guestmember"
      redirect_to about_path, notice: 'ゲストはプロフィール編集画面へ遷移できません。'
    end
  end

end
