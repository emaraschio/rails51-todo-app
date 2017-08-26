require 'rails_helper'

RSpec.describe User, type: :model do
	let(:valid_attributes){
		{
			first_name: "John",
			last_name: "Kowalsky",
			email: "john@mail.com"
		}
	}
	context "validations" do
		let(:user){ User.new(valid_attributes) }
		
		before do
			User.create(valid_attributes)
		end

		it "requires an email" do
			expect(user).to validate_presence_of(:email)
		end

		it "requires a unique email" do
			expect(user).to validate_uniqueness_of(:email)
		end

		it "requires a unique email (case insensitive)" do
			user.email = "JOHN@KOWALSKY.COM"
			expect(user).to validate_uniqueness_of(:email)
		end
	end

	describe "#downcase_email" do
		it "makes the email attribute lowercase" do
			user = User.new(valid_attributes.merge(email: "JOHN@KOWALSKY.COM"))
			# user.downcase_email
			# expect(user.email).to eq("john@kowalsky.com")
			expect{ user.downcase_email }.to change{ user.email }.from("JOHN@KOWALSKY.COM").to("john@kowalsky.com")
		end
	end

	it "downcases an email before saving" do
		user = User.new(valid_attributes)
		user.email = "JOHN@KOWALSKY.COM"
		expect(user.save).to be true
		expect(user.email).to eq("john@kowalsky.com")
	end
end
