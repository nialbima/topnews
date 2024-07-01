require "rails_helper"

RSpec.describe Flag, type: :model do
  it "has a valid factory" do
    flag = build :flag
    expect(flag).to be_valid
    expect(flag).to belong_to(:user)
    expect(flag).to belong_to(:story)
  end

  it "increments its story's flag count when created" do
    story = create :story
    user = create :valid_user

    expect { create :flag, story: story, user: user }.to change { story.reload.flags_count }.from(0).to(1)
  end

  it "decrements its story's flag count when deleted" do
    user = build :valid_user
    flag = build :flag, user: user
    story = create :story, flags: [flag]

    flag.reload
    expect { flag.destroy }.to change { story.reload.flags_count }.from(1).to(0)
  end
end
