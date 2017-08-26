module PeopleHelper
  def generate_tree(node)
    html = '<ul>'
    html += "<li><a href=#>#{node.name}</a>"
    html += generate_descendents (node)
    html += '</li>'
    html += '</ul>'
    html.html_safe
  end

  def generate_descendents (node)
    if node.has_children?
      html = '<ul>'
      node.children.each do |child|
        html += "<li><a href=#>#{child.name}</a>"
        if child.has_children?
          html += generate_descendents(child)
        end
        html += '</li>'
      end
      html += '</ul>'
    else
      html = ''
    end
  end
end
