feature "Home index page" do
  scenario "loads the correct text" do
    visit root_path

    expect(page).to have_text("hello and welcome to the kapi application")
  end

  scenario "loads the correct text with js", :js => true do
    visit root_path

    expect(page).to have_text("hello and welcome to the kapi application")
  end
end

