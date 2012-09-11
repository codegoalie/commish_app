module ApplicationHelper

  def active_nav(page)
    'active' if  page == @controller
  end
end
