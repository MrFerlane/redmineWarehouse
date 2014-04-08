Redmine::Plugin.register :redmine_warehouse do
  name 'Redmine Warehouse plugin'
  author 'Zheltukhin Alexey'
  description 'This plugin is test task for RedmineCRT'
  version '1.0.0'

  project_module :warehouse do
    permission :create_merchandises, { :merchandises => [:new, :create] }
    permission :view_merchandises, { :merchandises => [:index, :show] }
    permission :edit_merchandises, { :merchandises => [:edit, :update] }
    permission :delete_merchandises, { :merchandises => [:destroy] }
  end

  permission :test_static_pages, { :test_static_pages => [:index] }, :public => true

  menu :project_menu, :merchandises, { :controller => 'merchandises', :action => 'index' }, :caption => :label_warehouse, :after => :issues, :param => :project_id
  menu :project_menu, :test_static_pages, { :controller => 'test_static_pages', :action => 'index' }, :caption => :test_static_page, :last => :true, :param => :project_id
end

require 'redmine_warehouse/hooks/view_issues_show_details_bottom_hook'
