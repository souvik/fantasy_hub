class Formula1APIService
  include HTTParty

  base_uri 'https://fantasy-stage-api.formula1.com/partner_games/f1'

  def fetch_fantasy_teams
    self.class.get('/teams', verify: false)
  end

  def fetch_fantasy_players
    self.class.get('/players', verify: false)
  end
end
