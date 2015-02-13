require 'feature_spec_helper'

feature "Home index page" do
  before(:all) do
    @user = create(:user_with_profile)
  end

  scenario "loads the correct text" do
    visit root_path

    expect(page).to have_text("hello and welcome to the kapi application")
    expect(page).to have_text(@user.email)
    expect(page).to have_text(@user.profile.description)
  end

  scenario "loads the correct text with js", :js => true do
    pending
    visit root_path

    expect(page).to have_text("hello and welcome to the kapi application")
  end

  scenario "can sign in" do
    visit root_path
    click_on("sign in")
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_on("Sign in")

    expect(page).to have_text("Signed in successfully.")
  end

  scenario "can sign out" do
    visit root_path
    click_on("sign in")
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_on("Sign in")
    click_on("sign out")

    expect(page).to have_text("Signed out successfully.")
  end

  scenario "can sign up" do
    visit root_path
    click_on("sign up")
    fill_in "Email", :with => "tester_new@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_on("Sign up")

    expect(page).to have_text("Welcome! You have signed up successfully.")
  end

  scenario "when signed in can create a new profile" do
    visit root_path
    click_on("sign up")
    fill_in "Email", :with => "tester_new@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_on("Sign up")

    expect(User.last.email).to eq("tester_new@example.com")
    profile_count = Profile.count
    expect(page).to have_text("create profile")
    click_on("create profile")
    fill_in "Location", :with => "tester_new location"
    fill_in "Tagline", :with => "tester_new tagline"
    fill_in "Description", :with => "tester_new description"
    click_on("Create Profile")

    expect(page).to have_text("Profile created successfully")
    expect(Profile.count).to eq(profile_count + 1)
    expect(User.last.profile).to eq(Profile.last)
    expect(page).to have_text(Profile.last.location)
    expect(page).to have_text(Profile.last.tagline)
    expect(page).to have_text(Profile.last.description)
  end

  scenario "when not signed in cannot create/edit profile" do
    visit root_path

    expect(page).not_to have_text("create profile")
    expect(page).not_to have_text("edit profile")

    visit edit_profile_path(Profile.last)
    expect(page).
      to have_text("You need to sign in or sign up before continuing.")

    visit new_profile_path
    expect(page).
      to have_text("You need to sign in or sign up before continuing.")
  end

  scenario "when signed in can edit their profile" do
    visit root_path
    click_on("sign in")
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_on("Sign in")

    expect(page).not_to have_text("create profile")
    expect(page).to have_text("edit profile")
    click_on("edit profile")
    fill_in "Location", :with => "tester_new location2"
    fill_in "Tagline", :with => "tester_new tagline2"
    fill_in "Description", :with => "tester_new description2"
    click_on("Update Profile")

    expect(page).to have_text("Profile updated successfully")
    expect(page).to have_text("tester_new location2")
    expect(page).to have_text("tester_new tagline2")
    expect(page).to have_text("tester_new description2")
  end

  scenario "can browse another profile" do
    user2 = create(:user_with_profile)
    visit root_path

    # the last created profile is shown on home#index
    expect(page).to have_text(user2.email)
    click_on("random profile")
    expect(page).to have_text("Show profile page")
    expect(page).not_to have_text(user2.email)
  end

  scenario "can search for profiles" do
    user2 = create(:user_with_profile)
    user2.profile.location = "super secret location"
    user2.profile.name = "bob tester works"
    user2.profile.save
    visit root_path
    fill_in "Query", :with => "bob"
    click_on "Search"

    expect(page).to have_text("bob tester works")

    fill_in "Query", :with => "Test location"
    click_on "Search"

    expect(page).to have_text(@user.profile.display_name)
    expect(page).not_to have_text(user2.email)

    fill_in "Query", :with => "super secret location"
    click_on "Search"

    expect(page).to have_text(user2.profile.display_name)
    expect(page).not_to have_text(@user.email)
  end
end

