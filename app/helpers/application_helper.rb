module ApplicationHelper
  
  def full_page_title(title)
    default_title = "Bloggit"
    if title.empty?
      default_title
    else
      title + " | " + default_title
    end
  end
  
  
end
