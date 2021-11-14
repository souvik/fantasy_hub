require 'rails_helper'

RSpec.describe FantasyTeamImportJob, type: :job do
  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  describe '#perform_later' do
    it 'enqueued the job' do
      expect {
        FantasyTeamImportJob.perform_later
      }.to have_enqueued_job
    end

    it 'enqueued as default' do
      expect {
        FantasyTeamImportJob.perform_later
      }.to have_enqueued_job.on_queue('default')
    end
  end
end
