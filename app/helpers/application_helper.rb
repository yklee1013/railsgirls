module ApplicationHelper
  def render_flash
    render :partial => 'shared/flash', :locals => {:flash => flash} unless flash.empty?
  end

  def markdown(text)
    return '' if text.blank?

    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def notice_message
    flash_messages = []
    flash.each do |type, message|
      if message
        type = :success if type == :notice
        html = <<-HTML
        <div class=\"alert fade in alert-#{type}\">
          <a class="close" data-dismiss="alert"><i class="icon-remove"></i></a>
          #{message}
        </div>
        HTML
        flash_messages << html
      end
    end
    flash_messages.join("\n").html_safe
  end

  def set_title(title = "", is_root = false)
    if is_root
      title_str = title
    else
      title_str = "#{title} - "
    end

    content_for :title do
      title_str
    end
  end
end
