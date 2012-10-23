require 'spec_helper'

describe User do
    before { @user = User.new(firstname: "test", lastname:"Huf", gender:"male",
                              default_currency:"USD", date_of_birth: 10.year.ago, access_token: "alkdlafalkdsflksdfjlakdh") }
    
    subject { @user }

    it { should respond_to(:firstname) }
    it { should respond_to(:lastname) }
    it { should respond_to(:gender) }
    it { should respond_to(:default_currency) }
    it { should respond_to(:date_of_birth) }
    it { should respond_to(:access_token) }

    it { should respond_to(:registrations) }
    it { should respond_to(:events) }

    it { should be_valid }

    describe "when user first name is not present" do
        before { @user.firstname = '' }
        it { should_not be_valid }
    end

    describe "when user last name is not present" do
        before { @user.lastname = '' }
        it { should_not be_valid }
    end

    describe "when access_token is not present" do
        before { @user.access_token = '' }
        it { should_not be_valid }
    end

    describe "when user access_token is not unique" do
        before {
            @user_with_same_token = @user.dup
            @user_with_same_token.save
        }

        it { should_not be_valid }
    end

    describe "registering events" do
        let(:event) { FactoryGirl.create(:event) }
        before {
            @user.save
            @user.register(event)
        }

        it { should be_registered(event) }
        its(:events) { should include(event) }
    end
end
