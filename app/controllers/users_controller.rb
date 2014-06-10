class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  helper_method :sort_column, :sort_direction

	#load_and_authorize_resource
	
 	def index
		@users = User.search(params[:search]).order(sort_column + " " + sort_direction).page params[:page]
		#authorize! :read, @users
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

	def show
		@user = User.find(params[:id])
	end
	
	def edit
		@user = User.find(params[:id])
		#authorize! :edit, @user
	end

	def update
		@user = User.find(params[:id])
    respond_to do |format|
    if @user.update_attributes(params[:user])
      format.html {flash[:success] = "User was updated"}
      format.js
    else
      format.html {render "edit"}
      format.js
    end
  	end
	end

	def destroy
		User.find(params[:id]).destroy
		respond_to do |format|
    	format.html { redirect_to(users_url, :notice => 'User destroyed!') }
    	format.js   { render :nothing => true }
		#authorize! :destroy, @user
		end
	end

	def sort
		params[:user].each_with_index do |id, index|
    	User.update_all({position: index+1}, {id: id})
  	end
  	render nothing: true
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

	  def sort_column
	    User.column_names.include?(params[:sort]) ? params[:sort] : 'nickname'
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
	  end
end