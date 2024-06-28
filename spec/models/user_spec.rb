require "rails_helper"

RSpec.describe User do
  it "should pass validation given valid input" do
    user = build(:valid_user)

    expect(user).to be_valid
    aggregate_failures do
      expect(user).to validate_presence_of(:first_name)
      expect(user).to validate_presence_of(:last_name)
      expect(user).to validate_presence_of(:email)
    end
  end

  it "requires a password" do
    user = build(
      :user,
      first_name: :foo,
      last_name: :bar,
      email: "f@b.c",
      password: nil
    )
    expect(user).to be_invalid
    user.password = "foobar123"
    expect(user).to be_valid
  end
end
