require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "testing scaffold" do
    it "has a valid factory" do
      expect(build(:user)).to be_valid
    end
  end

  describe "invalid params" do
    context "email" do
      it "should be invalid without email" do
        expect(build(:user, email:nil)).not_to be_valid
      end

      it "should be invalid with duplicate email" do
        user = create(:user, email: "dupy@test.com")
        expect(build(:user, email: "dupy@test.com")).not_to be_valid
      end
    end

    context "password" do
      it "should be invalid without password" do
        expect(build(:user, password:nil)).not_to be_valid
      end
    end
  end
end
