class AdminsController < ApplicationController
	before_filter :load_admin, only: [:show, :edit, :update, :destroy]
	helper_method :sort_column, :sort_direction
	load_and_authorize_resource
	
 	def index
		@admins = Admin.search(params[:search]).order(sort_column + " " + sort_direction).page params[:page]
	end

	def new
		@admin = Admin.new
	end

	def create
	  @admin = Admin.new(params[:admin])
	  if @admin.save
	    redirect_to admins_path, :notice => "Admin was succesfully created!"
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
	    if @admin.update_attributes(params[:admin])
	      format.html { redirect_to(@admin, :notice => "Admin was updated")}
	      format.js
	    else
	      format.html {render "edit"}
	      format.js
	    end
  	end
	end

	def destroy
		@admins = Admin.search(params[:search]).order(sort_column + " " + sort_direction).page params[:page]
		@admin.destroy
    respond_to do |format|
    	format.html { redirect_to(users_url, :notice => 'Admin destroyed!') }
    	format.js
		end
	end

	def sort
			params[:admin].each_with_index do |id, index|
	    	Admin.update_all({position: index+1}, {id: id})
	  	end
	  	render nothing: true
	end

	private

		def load_admin
			@admin = Admin.find(params[:id])
		end

   	def sort_column
	    Admin.column_names.include?(params[:sort]) ? params[:sort] : 'nickname'
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
	  end
end
