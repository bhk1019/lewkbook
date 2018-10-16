require 'rails_helper'

RSpec.describe User, type: :model do
	
	describe "new user" do

		context "with all valid attributes" do
			before(:each) do
				@user = User.new(name: 'John Smith', email: 'example@example.com', password: 'password', password_confirmation: 'password')
			end
			it "should be valid" do
				expect(@user).to be_valid
			end
			it "should have present name" do
				expect(@user.name).to be_present
			end
			it "should have short enough name" do
				expect(@user.name.length).to be < 50
			end
			it "should have long enough password" do
				expect(@user.password.length).to be > 6
			end
		end

		context "with valid email" do
			before(:each) do
				@user = User.new(name: 'John Smith', email: 'exaMple@example.com', password: 'password', password_confirmation: 'password')
			end
			it "should have short enough email" do
				expect(@user.email.length).to be < 255
			end
			it "should save as downcased email" do
				@user.save
				expect(@user.email).to eq "example@example.com"
			end
			valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
			valid_addresses.each do |email|
				it "should be valid for #{email}" do
					@user.email = email
					expect(@user).to be_valid
				end
			end
		end

		context "with empty initialization" do
			before(:each) do
				@user = User.new
			end
			it "should be invalid" do
				expect(@user).to be_invalid
			end
			it "should have too short of a name" do
				@user.name = 'a' * 255
				expect(@user.name.length).to be > 50
			end
		end

		context "with invalid email" do
			before(:each) do
				@user = User.new(name: "John Smith")
			end
			invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com foo@bar..baz.com]
			invalid_addresses.each do |email|
				it "should be invalid for #{email}" do
					@user.email = email
					expect(@user).to be_invalid
				end
			end
		end

		context "with duplicate email" do
			before(:each) do
				@user = User.new(name: "John Smith", email: "user@example.com")
				@user.save
			end
			it "should be invalid" do
				duplicate_user = @user.dup
				duplicate_user.email = @user.email.upcase
				expect(duplicate_user).to be_invalid 
			end
		end

		context "with no password" do
			before(:each) do
				@user = User.new(name: "john smith", email: "user@example.com")
			end
			it "should be invalid" do
				expect(@user).to be_invalid
			end
		end

		context "with short password" do
			before(:each) do
				@user = User.new(name: "john smith", email: "user@example.com", password: '123', password_confirmation: '123')
			end
			it "should be invalid" do
				expect(@user).to be_invalid
			end
		end
	end
end
