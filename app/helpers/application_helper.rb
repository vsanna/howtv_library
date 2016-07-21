module ApplicationHelper
  def hide_header
    (params[:controller] == 'users/sessions') && ( (params[:action] == 'new') || (params[:action] == 'create') )
  end

  def form__cell__alert(model, field)
    res = ''
    model.errors.full_messages_for(field).each do |message|
      res += content_tag :span, message, class: 'form--cell--alert'
    end
    res.html_safe
  end
end
