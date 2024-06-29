require "rails_helper"

RSpec.describe HackerNews::UpdateCache, :interactor do
  it "writes the new ranking to the cache" do
    new_ranking = [[0, 33], [1, 66], [2, 99], [3, 132], [4, 155], [5, 188]]
    context = described_class.call(new_ranking: new_ranking)

    expect(context).to be_a_success
    expect(Rails.cache.read(HackerNews::TOP_STORIES_CACHE_KEY)).to eq(new_ranking)
  end
end
