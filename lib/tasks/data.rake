namespace :load do
  desc "Load player data from FFNerd API."
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

  desc "Load weekly projections from FFNerd API."
  task :projections, [:week] => :environment do |t, args|
    args.with_defaults(week: Projection.current_week + 1)

    week = args.week.to_i

    errors = []
    projections = []

    while projections.length == 0
      projections = FFNerd.projections(week)
      week -=1
    end
    week += 1

    projections.each do |projection|
      unless player = Player.find_by_ffn_id(projection[:id])
        player = Player.create(name: projection[:name], team: projection[:team],
                               position: projection[:position], ffn_id: projection[:id])

        if player.errors.any?
          error = "Couldn't create new player: #{projection[:name]} (#{projection[:id]})"
          player.errors.full_messages.each do |msg|
            error << "\t#{msg}"
          end
          errors << error
          next
        end
      end

      if existing_projection = Projection.where(week: week, player_id: player.id).first
        if existing_projection.update_attributes(projection[:projection])
          puts "Updated week #{week} projection for #{player}"
        else
          error =  "Couldn't update week #{week} projection for #{player}"
          existing_projection.errors.full_messages.each do |msg|
            error << "\t#{msg}"
          end
          errors << error
        end
      else
        if existing_projection = Projection.create({player_id: player.id, 
                                                 rank: projection[:rank]
                                                }.merge(projection[:projection]) )
          puts "Created week #{week} projection for #{player}"
        else
          error = "Couldn't create week #{week} projection for #{player}"
          existing_projection.errors.full_messages.each do |msg|
            error << "\t#{msg}"
          end
          errors << error
        end
      end
    end

    puts "\n\n"
    if errors.any?
      puts "The following errors occurred:"
      errors.each do |e|
        puts e
      end
    else
      puts "No errors. All projections imported successfully."
    end
  end

end
