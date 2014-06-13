class AdminsController < ApplicationController
	helper_method :sort_column, :sort_direction
	#load_and_authorize_resource
	
 	def index
		@admins = Admin.search(params[:search]).order(sort_column + " " + sort_direction).page params[:page]
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

   	def sort_column
	    Admin.column_names.include?(params[:sort]) ? params[:sort] : 'nickname'
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
	  end
end
