class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

 	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
	  @user = User.new(params[:user])
	  if @user.save
	  	flash.now[:success] = "Your account was successfully created!"
	    redirect_to @user
	  else
	    render "new"
	  end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User was updated"
      redirect_to root_path
    else
      render "edit"
    end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = 'User destroyed!'
		redirect_to root_path
	end

	private

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def signed_in?
    	!current_user.nil?
  	end

  	def current_user?(user)
    	user == current_user
  	end
end