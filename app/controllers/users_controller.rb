class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource except: :new

 	def index
		@user = User.new
		@users = User.search(params[:search]).order(sort_column + " " + sort_direction).page params[:page]
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
	end

	def update
		@user = User.find(params[:id])
    respond_to do |format|
	    if @user.update_attributes(params[:user])
	      format.html { redirect_to(@user, :notice => "User was updated")}
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
		end
	end

	def sort
		params[:user].each_with_index do |id, index|
    	User.update_all({position: index+1}, {id: id})
  	end
  	render nothing: true
	end

	private

	  def sort_column
	    User.column_names.include?(params[:sort]) ? params[:sort] : 'nickname'
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
	  end
end