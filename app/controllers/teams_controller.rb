class TeamsController < ApplicationController
  include Authenticable

  def index
    @teams = Current.user.teams
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new
  end
end
