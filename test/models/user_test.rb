require "test_helper"

class UserTest < ActiveSupport::TestCase

  before
  blackheart = User.create(username: "Blackheart", email: 'blackheart@evilesp.net', password: 'soevil!', premium_member?: true)
  king_george = User.create(username: "King George", email: 'kinggeorge@goodesp.org', password: 'goodguyswin!', admin?: true)
   
  def test_it_validates_username_uniqueness
    blackheart_wannabe = User.new(username: "Blackheart", email: 'blackheart2@evilesp.net', password: 'copycat')
    assert blackheart_wannabe.save == false
  end

  def test_it_validates_email_format
    invalid_email_user = User.new(username: "validname", email: "invalid.email", password: 'validpassword')
    assert invalid_email_user.save == false
    invalid_email_user = User.new(username: "validname", email: "@invalid.email", password: 'validpassword')
    assert invalid_email_user.save == false
    invalid_email_user = User.new(username: "validname", email: "invalid.email@nothing", password: 'validpassword')
    assert invalid_email_user.save == false
    valid_email_user = User.new(username: "validname", email: "validformat@email.com", password: 'validpassword')
    assert valid_email_user.save == true
  end


end
