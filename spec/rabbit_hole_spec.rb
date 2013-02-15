require 'spec_helper'

describe RabbitHole do
  describe ".setup" do
    RabbitHole::OPTION_NAMES.each do |name|
      it "should set the #{name}" do
        RabbitHole.setup do |config|
          config.send("#{name}=", name)
          RabbitHole.send(name).should == name
        end
      end
    end

    after(:each) do
      RabbitHole.set_defaults
    end
  end

  describe "including into a controller" do
    let(:controller_class) { ApplicationController }

    before do
      controller_class.send(:include, RabbitHole)
    end

    it "responds to check_auth!" do
      controller_class.new.should respond_to :check_auth!
    end

    it "inserts before_filter after including" do
      RabbitHole.included_into.should_not be_nil
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
end