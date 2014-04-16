require 'spec_helper'

describe User do
  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :profile }

    context "given I have a user registered" do
      before{ FactoryGirl.create(:jhon_doe_user); }
      it { should validate_uniqueness_of :name }
    end
  end

  describe "#to_s" do
    it "should returns the user name" do
      subject.name = "Jhon Doe"
      expect(subject.to_s).to eql "Jhon Doe"
    end
  end
end
