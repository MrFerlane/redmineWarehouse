module RedmineWarehouse
  module Hooks
    class WarehouseHooks  < Redmine::Hook::ViewListener
      render_on( :view_issues_show_details_bottom, :partial => "issues/merchandise_links" )
    end
  end
end