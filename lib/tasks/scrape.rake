require 'open-uri'
namespace :scrape do
  desc "Scrapes ESPN Fantasy Football team pages for player names"
  task :players, [:team_id, :league_id, :espn_team_id] => :environment do |t, args|

    unless team = FantasyTeam.find(args.team_id)
      puts "Couldn't find team with id: #{args.team_id}"
      return
    end

    link = "http://games.espn.go.com/ffl/clubhouse?leagueId=#{args.league_id}&teamId=#{args.espn_team_id}&seasonId=#{Date.today.year}"

    page = open(link) {|f| Hpricot(f) }
    player_table = page.search("//table[@id='playertable_0")
    player_links = player_table.search("//td[@class='playertablePlayerName']/a[1]")
    player_links.each do |a|
      name = a.inner_html
      if player = Player.find_by_name(name)
        team.players << player
      else
        puts "Couldn't find player with name '#{name}'"
      end
    end
  end
end

