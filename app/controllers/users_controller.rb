class UsersController < ApplicationController
  before_filter :set_user, except: [:index, :new, :create, :sort]
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource except: :new

 	def index
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
	end
	
	def edit
	end

	def update
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
		@user.destroy
		respond_to do |format|
    	format.html { redirect_to(users_url, :notice => 'User destroyed!') }
    	format.json { head :no_content }
    	format.js   { render :layout => false }
		end
	end

	def sort
		params[:user].each_with_index do |id, index|
    	User.update_all({position: index+1}, {id: id})
  	end
  	render nothing: true
	end

	private

		def set_user
			@user = User.find(params[:id])
		end

	  def sort_column
	    User.column_names.include?(params[:sort]) ? params[:sort] : 'nickname'
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
	  end
end