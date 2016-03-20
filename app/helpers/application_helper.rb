module ApplicationHelper
  def hide_header
    (params[:controller] == 'users/sessions') && ( (params[:action] == 'new') || (params[:action] == 'create') )
  end
end
