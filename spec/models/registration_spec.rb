require 'spec_helper'

describe Registration do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }
  let(:registration) { user.registrations.build(event_id: event.id) }

  subject { registration }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
        expect do
            Registration.new(user_id: user.id)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "register method" do
    it { should respond_to(:event) }
    it { should respond_to(:register) }

    its(:event) { should == event }
    its(:register) { should == user }
  end

  describe "when user id is not present" do
    before { registration.user_id = nil }
    it { should_not be_valid }
  end

  describe "when event id is not present" do
    before { registration.event_id = nil }
    it { should_not be_valid }
  end
end
