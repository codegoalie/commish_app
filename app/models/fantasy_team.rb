class FantasyTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :fantasy_league
  has_and_belongs_to_many :players, uniq: true

  attr_accessible :fantasy_league_id, :name, :espn_id

  def to_s
    name
  end

  def weekly_projection(week, type=:standard)
    points = 0
    players.each{|p| points += p.weekly_projection(week, type) }
    points
  end

  def update_roster
    link = "http://games.espn.go.com/ffl/clubhouse?leagueId=#{fantasy_league.espn_id}&teamId=#{espn_id}&seasonId=#{fantasy_league.year}"

    page = Nokogiri::HTML(open(link))
    player_table = page.search("//table[@id='playertable_0']")
    player_data = player_table.search("//td[@class='playertablePlayerName']")

    errors = []
    count = 1
    if player_data.any?
      players.destroy_all

      player_data.each do |d|
        text = d.text.split(', ')

        if text.length == 1 # name is a defense team
          team_name = text[0].split(' ')[0]
          if player = Player.where("name like '%#{team_name}%'")
            players << player
          else
            errors << "\nCouldn't find defense team with name '#{name}'"
          end
        else #name is a player
          name = text[0].gsub('*', '')
          modifiers = text[1].gsub("\u00A0", ' ').split(' ')
          #team = modifiers[0].upcase
          position = modifiers[1].upcase

          if player = Player.where(name: name, position: position).first
            players << player
          else
            errors << "\nCouldn't find player with name '#{name}'"
          end
        end
        count += 1
      end
    else
      errors << "No player links found on ESPN. Maybe ESPN changed their page markup?"
    end
    errors
  end
end
