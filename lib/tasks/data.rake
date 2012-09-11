namespace :load do
  desc "Load data from FFNerd API."
  task :players => :environment do
    FFNerd.player_list.each do |player_attrs|
      player_attrs[:ffn_id] = player_attrs.delete(:id)
      player = Player.find_by_ffn_id(player_attrs[:ffn_id])
      if player
        player.update_attributes(player_attrs)
        action = 'updat'
      else
        player = Player.create(player_attrs)
        action = 'creat'
      end
      if player && player.errors.empty?
        puts "#{action.titleize}e #{player.name}(#{player.ffn_id})"
      else
        puts "Error #{action}ing #{player_attrs[:name]}(#{player_attrs[:ffn_id]}:"
        if player
          player.errors.full_messages.each do |msg|
            puts "\t#{msg}"
          end
        else
          puts "\tplayer instance not defined."
        end
      end
    end
  end

end
