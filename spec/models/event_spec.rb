require 'spec_helper'

describe Event do
    before { @event = Event.new(name:"test event", address: "test addr", email: "test@example.com",
                                phone:"243234", time: 1.day.ago, club: "club", short_desc:"short",
                                desc: "long desc") }
    subject { @event }

    it { should respond_to(:name) }
    it { should respond_to(:subname) }
    it { should respond_to(:address) }
    it { should respond_to(:email) }
    it { should respond_to(:phone) }
    it { should respond_to(:time) }
    it { should respond_to(:club) }
    it { should respond_to(:short_desc) }
    it { should respond_to(:desc) }
    it { should respond_to(:price) }

    it { should respond_to(:registrations) }
    it { should respond_to(:registers) }

    it { should be_valid }
    
    describe "when name is not present" do
        before { @event.name = '' }
        it { should_not be_valid }
    end

    describe "when address is not present" do
        before { @event.address = '' }
        it { should_not be_valid }
    end

    describe "when email is not present" do
        before { @event.email = '' }
        it { should_not be_valid }
    end

    describe "when phone is not present" do
        before { @event.phone = '' }
        it { should_not be_valid }
    end

    describe "when time is not present" do
        before { @event.time = nil }
        it { should_not be_valid }
    end

    describe "when club is not present" do
        before { @event.club = '' }
        it { should_not be_valid }
    end

    describe "when short description is not present" do
        before { @event.short_desc = '' }
        it { should_not be_valid }
    end

    describe "when description is not present" do
        before { @event.desc = '' }
        it { should_not be_valid }
    end

    describe "when short description is too long" do
        before { @event.short_desc = 'a' * 51 }
        it { should_not be_valid }
    end

    describe "when email format is invalid" do
        it "should be invalid" do
            addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                           foo@bar_baz.com foo@bar+baz.com]
            addresses.each do |invalid_addr|
                @event.email = invalid_addr
                @event.should_not be_valid
            end
        end
    end

    describe "when email format is valid" do
        it "should be valid" do
            addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
            addresses.each do |valid_addr|
                @event.email = valid_addr
                @event.should be_valid
            end
        end
    end

    describe "user registering event" do
        let(:user) { FactoryGirl.create(:user) }

        before {
            @event.save
            user.register(@event)
        }

        its(:registers) { should include(user) }
    end
end
