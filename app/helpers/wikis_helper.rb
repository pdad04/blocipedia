module WikisHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(escape_html: true);
    markdown = Redcarpet::Markdown.new(renderer, tables: true, fenced_code_blocks: true)

    markdown.render(text).html_safe
  end
end
