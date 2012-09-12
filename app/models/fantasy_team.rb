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

    page = open(link) {|f| Hpricot(f) }
    player_table = page.search("//table[@id='playertable_0")
    player_links = player_table.search("//td[@class='playertablePlayerName']/a[1]")

    errors = []
    if player_links.any?
      players.destroy_all

      player_links.each do |a|
        name = a.inner_html
        names = name.split(' ')

        if (names[1] == 'D/ST' && player = Player.where("name like '%#{names[0]}%'")) ||
          player = Player.find_by_name(name)

          players << player
        else
          errors << "\nCouldn't find player with name '#{name}'"
        end
      end
    else
      errors << "No player links found on ESPN. Maybe ESPN changed their page markup?"
    end
    errors
  end
end
