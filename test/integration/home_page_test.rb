require 'test_helper'

class HomePageTest < Capybara::Rails::TestCase
  @@post = Post.make
  before
  User.create(username: 'Alida', email: 'alida@example.com', password: 'iscool')
  User.create(username: 'Naiya', email: 'naiya@example.com', password: 'isawesome', premium_member?: true)
  User.create(username: 'George', email: 'george@example.com', password: 'isspiffy', admin?: true)

  def setup
    visit root_path
  end

  def test_home_page_exists
    assert page.has_content?("Blackheart")
  end

  def test_home_page_has_nav_buttons
    visit '/home'
    assert find_link("Home").visible?
    assert find_link("Preview Blackheart").visible?
    assert find_link("About the Authors").visible?
    assert find_link("Forum").visible?
  end

  def test_home_page_has_sessions_buttons
    visit '/'
    within 'header' do
      assert find_link("Become A Member").visible?
      assert find_link("Sign In").visible?
    end
  end

  def test_a_new_user_can_sign_up
    skip
    #assert sign up partial closed
    click_link('Become A Member')
    #assert partial opens
    #within partial do
      fill_in 'username', :with => 'Newuser'
      fill_in 'email', :with => 'newuser@example.com'
      fill_in 'password', :with => 'isokay'
      fill_in 'passconf', :with => 'isokay'
      click_on 'Sign Up'
    #end
    #assert partial closes
    within 'header' do
      assert page.contains 'Welcome Newuser'
      refute find_link("Become A Member").visible?
      refute find_link("Sign In").visible?
      assert find_link("Log Out").visible?
      assert page.has_content?("Thank You")
    end
  end

  def test_a_member_can_sign_in
    skip
    #assert sign in partial closed
    click_link('Sign In')
    #assert partial opens
    #within partial do
    fill_in 'username', :with => 'Alida'
    fill_in 'password', :with => 'iscool'
    click_on 'Log In'
    #assert partial closes
    within 'header' do
      assert page.contains 'Logged in as Alida'
      assert find_link("View My Profile").visible?
      assert page.has_content?('Welcome back Alida!')
      refute find_link("Become A Member").visible?
      refute find_link("Sign In").visible?
      assert find_link("Log Out").visible?
    end
  end

  def test_a_user_can_sign_out
    skip
    click_link('Sign In')
    #within partial do
    fill_in 'username', :with => 'Alida'
    fill_in 'password', :with => 'iscool'
    click_on 'Log In'
    #end
    click_on "Log Out"
    assert page.has_content?("Have a nice day, Alida!")
    assert find_link("Become A Member").visible?
    assert find_link("Sign In").visible?
    refute find_link("Log Out").visible?
  end

  def test_a_premium_member_has_premium_content
    skip
    click_link('Sign In')
    #within partial do
    fill_in 'username', :with => 'Naiya'
    fill_in 'password', :with => 'isawesome'
    click_on 'Log In'
    #end
    assert page.has_content?('Welcome back')
    refute find_link("Preview Blackheart").visible?
    assert find_link("Blackheart").visible?
  end

  def test_an_admin_has_admin_content
    skip
    click_link('Sign In')
    #within partial do
    fill_in 'username', :with => 'Naiya'
    fill_in 'password', :with => 'isawesome'
    click_on 'Log In'
    #end
  end

end