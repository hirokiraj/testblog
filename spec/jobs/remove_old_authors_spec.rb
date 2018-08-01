require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe RemoveOldAuthors, type: :job do
  Sidekiq::Testing.inline!

  let!(:author1) { create(:author, age: 15) }
  let!(:author2) { create(:author, age: 22) }
  let!(:author3) { create(:author, age: 33) }
  let!(:author4) { create(:author, age: 44) }

  describe 'old authors' do
    before { RemoveOldAuthors.perform_now }

    it { expect(Author.count).to eq(2) }
  end
end
