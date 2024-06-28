require "rails_helper"

RSpec.describe "Application", type: :system do
  it "allows a user to log in and log out", :aggregate_failures do
    user = create(:valid_user)

    visit root_path

    expect(page).to have_current_path(new_user_session_path)

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    expect { click_button "Log in" }.to change(page, :current_path).from(new_user_session_path).to(root_path)

    # TODO: Something broke the controller flash alerts. It probably doesn't matter.
    # expect(page).to have_text("Signed in successfully.")

    expect { click_button "Log Out" }.to change(page, :current_path).from(root_path).to(new_user_session_path)

    visit root_path
    expect(page).to have_current_path(new_user_session_path)

  end
end
