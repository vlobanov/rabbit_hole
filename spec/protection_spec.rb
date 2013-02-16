require 'spec_helper'

describe RabbitHole::Protection do
  describe "including into a controller" do
    let(:controller_class) { ApplicationController }

    before do
      controller_class.send(:include, RabbitHole::Protection)
    end

    it "responds to check_auth!" do
      controller_class.new.should respond_to :check_auth!
    end
  end

  describe "protecting admin/index" do
    before do
      RabbitHole.setup do |config|
        config.redirect_to_if_denied = "/denied.html"
      end
    end

    it "redirects to ... if denied" do
      visit '/admin/index'
      current_path.should == RabbitHole.redirect_to_if_denied
    end
  end

  describe "logging in" do
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
  end
end