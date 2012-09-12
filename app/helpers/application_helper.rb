module ApplicationHelper

  def active_nav(page)
    'active' if  page == @controller
  end

  def active_nav_action(page)
    'active' if  page == @action
  end

  def show_errors_for(entity)
    haml = ''
    if entity.errors.any?
      haml << "#error_messages\n"
      haml << "\tThis #{t "models.#{entity.class.to_s.underscore}"} counldn't be saved because:\n"
      entity.errors.full_messages.each do |msg|
        haml << "\t.error_message\n\t\t#{msg}"
      end
    end
    puts haml
    engine = Haml::Engine.new(haml << "\n")
    engine.render
  end
end
