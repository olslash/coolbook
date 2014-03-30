require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

  end

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }
    it { should have_content(user.name) }
    it{ should have_title(user.name) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }
        it {should have_title('Sign up')}
        it {should have_content('error')}
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example user"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "coolmitch"
        fill_in "Confirmation", with: "coolmitch"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by 1
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        #redirects to new user page
        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        #flashes the alert
        it { should have_success_message 'Welcome' }

        describe "followed by signout" do
          before { click_link('Sign out') }
          it { should have_link('Sign in') }
        end

      end
    end
  end
end

