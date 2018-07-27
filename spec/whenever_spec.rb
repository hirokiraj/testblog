require 'rails_helper'

describe 'Whenever Schedule' do
  describe 'runners' do
    let(:schedule) { Whenever::Test::Schedule.new(file: 'config/schedule.rb') }
    it { expect(schedule.jobs[:runner].count).to eq(1) }

    it 'should have runners with existing constants' do
      schedule.jobs[:runner].each { |job| instance_eval(job[:task]) }
    end

    describe '#delete_old_authors' do
      let(:old_authors_runner) { schedule.jobs[:runner].find { |runner| runner[:task] == 'Author.delete_old_authors'  } }

      it 'should run every sunday at 3am' do
        expect(old_authors_runner[:every]).to eq([:sunday, { at: '3am' }])
      end
    end
  end
end
