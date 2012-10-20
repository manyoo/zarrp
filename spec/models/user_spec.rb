require 'spec_helper'

describe User do
    before { @user = User.new(name: "test", email: "test@example.com", access_token: "alkdlafalkdsflksdfjlakdh") }
    
    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:access_token) }
    it { should respond_to(:registrations) }
    it { should respond_to(:events) }

    it { should be_valid }

    describe "when user name is not present" do
        before { @user.name = '' }
        it { should_not be_valid }
    end

    describe "when user email is not present" do
        before { @user.email = '' }
        it { should_not be_valid }
    end

    describe "when access_token is not present" do
        before { @user.access_token = '' }
        it { should_not be_valid }
    end

    describe "when email format is invalid" do
        it "should be invalid" do
            addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                           foo@bar_baz.com foo@bar+baz.com]
            addresses.each do |invalid_addr|
                @user.email = invalid_addr
                @user.should_not be_valid
            end
        end
    end

    describe "when email format is valid" do
        it "should be valid" do
            addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
            addresses.each do |valid_addr|
                @user.email = valid_addr
                @user.should be_valid
            end
        end
    end

    describe "when user access_token is not unique" do
        before {
            @user_with_same_token = @user.dup
            @user_with_same_token.save
        }

        it { should_not be_valid }
    end
end
