class FantasyPlayerImportJob < ApplicationJob
  queue_as :default

  def perform
    formula1 = Formula1APIService.new
    players_response = formula1.fetch_fantasy_players
    players = JSON.parse(players_response.body, symbolize_names: true)[:players]
    players.each do |player|
      player_hash = process_player_json(player)
      begin
        existing_player = Player.find_by(id: player[:id])
        team = Team.find_by(id: player[:team_id])
        if team
          if existing_player
            existing_player.update!(player_hash.except(:id))
          else
            Player.create!(player_hash)
          end
        else
          raise "Unknown Team - #{player[:team_id]}"
        end
      rescue => e
        Rails.logger.error "Failed to save Player: #{e.record.id} due to: #{e.message}"
      end
    end
  end

  private
  def process_player_json(player_raw_data)
    raw_data = player_raw_data.dup
    raw_data.extract!(:id, :first_name, :last_name, :team_id, :price, :is_constructor)
  end
end
