require 'spec_helper'

describe RabbitHole do
  describe ".setup" do
    RabbitHole::OPTION_NAMES.each do |name|
      it "sets the #{name}" do
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

  describe "requires password" do
    it "raises exception if pass wasn't set" do
      RabbitHole.set_defaults
      expect { RabbitHole::password_correct?("-") }.to raise_exception
    end

    it "donesn't raise exception if pass was set" do
      RabbitHole.setup do |config|
        config.password= 'aaahaha'
      end
      expect { RabbitHole::password_correct?("-") }.not_to raise_exception
    end
  end

  describe "recognizes password" do
    before do
      RabbitHole.set_defaults
      RabbitHole.setup do |config|
        config.password= 'aaahaha'
      end
    end

    it "denies wrong" do
      RabbitHole::password_correct?("wrong_wrong_password").should == false
    end

    it "accepts right" do
      RabbitHole::password_correct?(RabbitHole::get_password).should == true
    end
  end
end