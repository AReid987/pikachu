class AdminsController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

 	def index
		@admins = Admin.all
	end

	def new
		@admin = Admin.new
	end

	def create
	  @admin = Admin.new(params[:admin])
	  if @admin.save
	    redirect_to admins_path, :notice => "Your account was succesfully created!"
	  else
	    render "new"
	  end
	end

	def show
		
	end

	def edit
		@admin = Admin.find(params[:id])
	end

	def update
		@admin = Admin.find(params[:id])
    if @admin.update_attributes(params[:admin])
      flash[:success] = "Admin was updated"
      redirect_to root_path
    else
      render "edit"
    end
	end

	private

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @admin = Admin.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def signed_in?
    	!current_user.nil?
  	end

  	def current_user?(user)
    	user == current_user
  	end
end
