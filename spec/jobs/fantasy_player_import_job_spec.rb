require 'rails_helper'

RSpec.describe FantasyPlayerImportJob, type: :job do
  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  describe '#perform_later' do
    it 'enqueued the job' do
      expect {
        FantasyPlayerImportJob.perform_later
      }.to have_enqueued_job
    end

    it 'enqueued as default' do
      expect {
        FantasyPlayerImportJob.perform_later
      }.to have_enqueued_job.on_queue('default')
    end
  end
end
