require 'spec_helper'

describe RabbitHole::Protection do
  before do
    RabbitHole.setup do |config|
      config.password= 'aaahaha'
    end
  end

  describe "protecting redirection" do
    it "goes to 'RabbitHole.redirect_to_if_denied' if denied" do
      visit '/admin/index'
      current_path.should == RabbitHole.redirect_to_if_denied
    end

    it "lets visit login page" do
      visit '/admin/login'
      current_path.should == '/admin/login'
    end
  end

  describe "logging in and out" do
    before do
      RabbitHole.setup do |config|
        config.redirect_to_after_login = '/admin/index'
      end
    end

    it "gives error if password is wrong" do
      visit '/admin/login'
      current_path.should == '/admin/login'
      within("#login") do
        fill_in 'password', :with => 'wrong_wrong_password'
      end
      click_button 'login'
      current_path.should == '/admin/login'
      page.should have_content RabbitHole::auth_failed_message
    end

    it "redirects and sets session if password is correct" do
      visit '/admin/login'
      current_path.should == '/admin/login'
      within("#login") do
        fill_in 'password', :with => RabbitHole::get_password
      end
      click_button 'login'
      current_path.should == RabbitHole.redirect_to_after_login
    end

    it "redirects and removes session after logging out" do
      # a small cheat
      RabbitHole.setup do |config|
        config.redirect_to_after_logout = '/after_logout.html'
      end

      visit '/session_storage_tester/remember'
      visit '/admin/logout'
      current_path.should == RabbitHole::redirect_to_after_logout
      visit '/admin/index'
      current_path.should == RabbitHole::redirect_to_if_denied
    end
  end
end