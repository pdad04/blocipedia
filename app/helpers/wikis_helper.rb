module WikisHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(escape_html: true);
    markdown = Redcarpet::Markdown.new(renderer, tables: true, fenced_code_blocks: true)

    markdown.render(text).html_safe
  end

  # Check if a user is a collaborator
  # If so checkbox in view should be checked
  def is_collaborator?(user, wiki)
    wiki.users.include?(User.find(user.to_i))
  end
end
