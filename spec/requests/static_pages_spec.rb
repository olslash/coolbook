require 'spec_helper'

describe "StaticPages" do
  describe "GET /static_pages" do
    it "should have the correct title" do
      StaticPagesController.action_methods.each do |meth|
        path = 'static_pages_'+meth.to_s+'_path'
        visit send(path)
        expect(page).to have_title(meth.to_s.capitalize)
      end
    end
    describe "Home page" do
      it "should have the content 'Sample App'" do
        visit static_pages_home_path
        expect(page).to have_content('Sample App')
      end
=begin
      it "should have the right title" do
        visit static_pages_home_path
        expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
      end
=end
    end
    describe "Help page" do
      it "should have the content 'Help'" do
        visit static_pages_help_path
        expect(page).to have_content('Help')
      end
=begin
      it "should have the right title" do
        visit static_pages_help_path
        expect(page).to have_title("Ruby on Rails Tutorial Sample App | Heop")
      end
=end
    end
    describe "ABOUT page" do
      it "should have the content 'About Us'" do
        visit static_pages_about_path
        expect(page).to have_content('About Us')
      end
=begin
      it "should have the right title" do
        visit static_pages_about_path
        expect(page).to have_title("Ruby on Rails Tutorial Sample App | About")
      end
=end
    end

  end
end
