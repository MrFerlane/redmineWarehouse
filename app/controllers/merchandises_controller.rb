class MerchandisesController < ApplicationController
  unloadable

  before_filter :find_project
  before_filter :get_issues, :only => [:edit, :new, :create, :update]
  before_filter :set_merchandise, :only => [:show, :edit, :update, :destroy]
  before_filter :check_view_permissions, :only => [:show, :index]
  before_filter :check_create_permissions, :only => [:new, :create]
  before_filter :check_update_permissions, :only => [:edit, :update]
  before_filter :check_destroy_permissions, :only => [:destroy]

  helper :sort
  include SortHelper

  def index

    sort_init 'name', 'asc'
    sort_update %w(name value count created_on)

    scope = Merchandise
    scope = scope.like(params[:name]) if params[:name].present?
    @merchandises = scope.order(sort_clause)

  end


  def new
    @merchandise = Merchandise.new
  end


  def edit
  end


  def show
  end


  def create
    @merchandise = Merchandise.new(params[:merchandise])

    respond_to do |format|
      if @merchandise.save
        format.html { redirect_to ({:controller => "merchandises", :action => "index", :project_id => @project}), :notice => l(:merchandise_create_notice) }
        format.json { head :no_content }
      else
        format.html { render :action => 'new' }
        format.api  { render_validation_errors(@merchandise) }
      end
    end
  end

  def update
    respond_to do |format|
      if @merchandise.update_attributes(params[:merchandise])
        format.html { redirect_to ({:controller => "merchandises", :action => "index", :project_id => @project}), :notice => l(:merchandise_update_notice) }
        format.json { head :no_content }
      else
        format.html { render :action => 'edit' }
        format.api  { render_validation_errors(@merchandise) }
      end
    end
  end

  def destroy
    @merchandise.destroy
    respond_to do |format|
      format.html { redirect_to({:controller => "merchandises", :action => "index", :project_id => @project}) }
      format.json { head :ok }
    end
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def set_merchandise
    @merchandise = Merchandise.find(params[:id])
  end

  def get_issues
    @issues = Issue.where(:project_id => @project.id)
  end

  def check_view_permissions
    (render_403; return false) unless User.current.allowed_to?(:view_merchandises, @project)
  end

  def check_create_permissions
    (render_403; return false) unless User.current.allowed_to?(:create_merchandises, @project)
  end

  def check_update_permissions
    (render_403; return false) unless User.current.allowed_to?(:edit_merchandises, @project)
  end

  def check_destroy_permissions
    (render_403; return false) unless User.current.allowed_to?(:delete_merchandises, @project)
  end

end
