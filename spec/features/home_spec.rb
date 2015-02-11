feature "Home index page" do
  before(:all) do
    @user = create(:user)
  end

  scenario "loads the correct text" do
    visit root_path

    expect(page).to have_text("hello and welcome to the kapi application")
    expect(page).to have_text(@user.email)
  end

  scenario "loads the correct text with js", :js => true do
    visit root_path

    expect(page).to have_text("hello and welcome to the kapi application")
  end
end

