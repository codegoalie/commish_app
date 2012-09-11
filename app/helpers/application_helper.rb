module ApplicationHelper

  def active_nav(page)
    'active' if  page == @controller
  end

  def show_errors_for(entity)
    haml = ''
    if @fantasy_team.errors.any?
      haml << '#error_messages'
      haml << "\tThis team counldn't be saved because:"
      @fantasy_team.errors.full_messages.each do |msg|
        haml << "\t.error_message\n\t\t#{msg}"
      end
    end
    engine = Haml::Engine.new(haml)
    engine.render
  end
end
