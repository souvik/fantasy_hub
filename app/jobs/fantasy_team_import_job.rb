require 'sidekiq-scheduler'

class FantasyTeamImportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    formula1 = Formula1APIService.new
    teams_response = formula1.fetch_fantasy_teams
    teams = JSON.parse(teams_response.body, symbolize_names: true)[:teams]
    teams.each do |team|
      team_hash = process_team_json(team)
      begin
        existing_team = Team.find_by(id: team[:id])
        if existing_team
          existing_team.update!(team_hash.except(:id))
        else
          Team.create!(team_hash)
        end
      rescue => e
        Rails.logger.error "Failed to save Team: #{e.record.id} due to: #{e.message}"
      end
    end
  end

  private
  def process_team_json(team_raw_data)
    raw_data = team_raw_data.dup
    team_data = raw_data.extract!(:id, :name, :short_name, :slug, :abbreviation)
    team_data.merge!(process_urls(**raw_data.extract!(:jersey_image, :team_logo_image, :team_badge_image)))
  end

  def process_urls(jersey_image:, team_logo_image:, team_badge_image:)
    {
      jersey_image_url: format_url(jersey_image[:url]),
      logo_image_url: format_url(team_logo_image[:url]),
      badge_image_url: format_url(team_badge_image[:url])
    }
  end

  def format_url(url_string)
    url_string.sub(/^https?\:/, '')
  end
end
