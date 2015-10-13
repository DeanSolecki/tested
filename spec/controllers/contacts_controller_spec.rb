require 'rails_helper'

describe ContactsController, :type => :controller do
	shared_examples 'public access to contacts' do
		describe 'GET #index' do
			context 'with params[:letter]' do
				it 'populates an array of contacts starting with the letter'
				it 'renders the :index template'
			end

			context 'without params[:letter]' do
				it "it populates an array of all contacts"
				it "renders an array of all contacts"
			end
		end

		describe 'GET #show' do
			it "assigns the requested contact to @contact"
			it "renders the :show template"
		end
	end

	shared_examples 'full access to contacts' do
		describe 'GET #new' do
			it "assigns a new Contact to @contact"
			it "assigns a home, office, and mobile phone to the new contact"
			it "renders the :new template"
		end

		describe 'GET #edit' do
			it "assigns the requested contact to @contact"
			it "renders the :edit template"
		end

		describe 'POST #create' do
			context "with valid attributes" do
				it "creates a new contact"
				it "redirects to the new contact"
			end

			context 'with invalid attributes' do 
				it "does not save the new contact"
				it "re-renders the new method"
			end
		end

		describe 'PATCH #update' do
			context "with valid attributes" do
				it "located the requested contact"
				it "changes contact's attributes"
				it "redirects to the updated contact"
			end

			context "with invalid attributes" do
				it "locates the requested contact"
				it "does not change contact's attributes"
				it "re-renders the edit method"
			end
		end

		describe 'DELETE #destroy' do
			it "deletes the contact"
			it "redirects to contacts#index"
		end
	end

	describe "admin access to contacts" do
		before :each do
			set_user_session(create(:admin))
		end

		it_behaves_like "public access to contacts"
		it_behaves_like "full access to contacts"
	end

	describe "user access to contacts" do
		before :each do
			set_user_session(create(:user))
		end

		it_behaves_like "public access to contacts"
		it_behaves_like "full access to contacts"
	end

	describe "guest access to contacts" do
		it_behaves_like "public access to contacts"

		describe 'GET #new' do
			it "requires login"
		end

		describe "POST #create" do
			it "requires login"
		end

		describe 'PATCH #update' do
			it "requires login"
		end

		describe 'DELETE #destroy' do
			it "requires login"
		end
	end
end
