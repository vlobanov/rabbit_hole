require 'spec_helper'

describe 'Session Storage' do
  let(:storage) { RabbitHole::Remember::SessionStorage.instance }

  describe "using session" do
    before do
      RabbitHole.setup do |config|
        config.remember_for= nil
      end
    end

    it "remembers" do
      visit '/session_storage_tester/remember'
      visit '/session_storage_tester/index'
      find(:id, 'session_val').text.should == 'admin'
      find(:id, 'cookies_val').text.should == ''
      find(:id, 'remembered').text.should == 'true'
    end

    it "forgets" do
      visit '/session_storage_tester/forget'
      visit '/session_storage_tester/index'
      find(:id, 'session_val').text.should == ''
      find(:id, 'cookies_val').text.should == ''
      find(:id, 'remembered').text.should == 'false'
    end
  end

  describe "using cookies" do
    before do
      RabbitHole.setup do |config|
        config.remember_for= 1.hour
      end
    end

    it "remembers" do
      visit '/session_storage_tester/remember'
      visit '/session_storage_tester/index'
      find(:id, 'session_val').text.should == ''
      find(:id, 'cookies_val').text.should == 'admin'
      find(:id, 'remembered').text.should == 'true'
    end

    it "forgets" do
      visit '/session_storage_tester/forget'
      visit '/session_storage_tester/index'
      find(:id, 'session_val').text.should == ''
      find(:id, 'cookies_val').text.should == ''
      find(:id, 'remembered').text.should == 'false'
    end
  end
end