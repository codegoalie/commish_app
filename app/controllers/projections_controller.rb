class ProjectionsController < ApplicationController

  def update
    week = params[:week] || Projection.current_week + 1
    projections = FFNerd.projections(week)

    if projections.empty?
      week -= 1
      projections = FFNerd.projections(week)
    end

    errors = []
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

    if errors.any?
      message =  "The following errors occurred while importing week #{week} projections:"
      errors.each do |e|
        message << "<br>#{e}" 
      end
      flash[:alert] = message
    else
      flash[:success] = "All week #{week} projections updated successfully."
    end

    redirect_to :back rescue redirect_to weeks_path

  end
end
