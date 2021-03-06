require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_error_message 'Invalid' }
      it { should have_title('Sign in') }

      describe "after visiting another page" do
        before { click_link 'Home' }
        it { should_not have_error_message 'Invalid' }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before { valid_signin(user) }

      it { should have_title(user.name) }
      it { should have_link('Sign out',     href: signout_path) }
      it { should have_link('Profile',      href: user_path(user)) }
      it { should_not have_link('Sign in',  href: signin_path) }
    end
  end
end
