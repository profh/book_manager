class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end
  
  def show
    @author = Author.find(params[:id])
  end
  
  def new
    @author = Author.new
  end
  
  def create
    @author = Author.new(params[:author])
    if @author.save
      flash[:notice] = "Successfully created author."
      redirect_to @author
    else
      render :action => 'new'
    end
  end
  
  def edit
    @author = Author.find(params[:id])
  end
  
  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(params[:author])
      flash[:notice] = "Successfully updated author."
      redirect_to @author
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    flash[:notice] = "Successfully destroyed author."
    redirect_to authors_url
  end
end
