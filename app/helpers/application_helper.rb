module ApplicationHelper
  def render_flash
    unless flash.empty?
      render(:template => 'shared/_flash', :layout => nil, :locals => {:flash => flash})
    end
  end
end
