require 'rails_helper'

describe ContactsController, :type => :controller do
  shared_examples 'public access to contacts' do
    let(:jones) { create(:contact, lastname: 'Jones') }
    let(:stevens) { create(:contact, lastname: 'Stevens') }
    let(:simon) { create(:contact, lastname: 'Simon') }

    describe 'GET #index' do
      subject { assigns(:contacts) }

      context 'with params[:letter]' do
        it 'populates an array of contacts starting with the letter' do
          get :index, letter: 'S'
          is_expected.to match_array([stevens, simon])
        end

        it 'renders the :index template' do
          get :index, letter: 'S'
          expect(response).to render_template :index
        end
      end

      context 'without params[:letter]' do
        it "it populates an array of all contacts" do
          get :index
          is_expected.to match_array([jones, stevens, simon])
        end

        it "renders an array of all contacts" do
          get :index
          expect(response).to render_template :index
        end
      end
    end

    describe 'GET #show' do
      it "assigns the requested contact to contact" do
        get :show, id: jones
        expect(assigns(:contact)).to eq jones
      end

      it "renders the :show template" do
        get :show, id: jones
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'full access to contacts' do
    subject { assigns(:contact) }

    describe 'GET #new' do
      it "assigns a new Contact to contact" do
        get :new
        is_expected.to be_a_new(Contact)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      let(:contact) { create(:contact) }

      it "assigns the requested contact to contact" do
        get :edit, id: contact
        is_expected.to eq contact
      end

      it "renders the :edit template" do
        get :edit, id: contact
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      before :each do
        @phones = [
          attributes_for(:phone),
          attributes_for(:phone),
          attributes_for(:phone)
        ]
      end

      context "with valid attributes" do
        it "creates a new contact" do
          expect{
            post :create, contact: attributes_for(:contact, phones_attributes: @phones)
          }.to change(Contact, :count).by(1)
        end

        it "redirects to the new contact" do
          post :create, contact: attributes_for(:contact, phones_attributes: @phones)
          expect(response).to redirect_to contact_path(assigns[:contact])
        end
      end

      context 'with invalid attributes' do 
        it "does not save the new contact" do
          expect{
            post :create, contact: attributes_for(:invalid_contact)
          }.to_not change(Contact, :count)
        end

        it "re-renders the new method" do
          post :create, contact: attributes_for(:invalid_contact)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      let(:contact) { create(:contact,
                             firstname: 'Frank',
                             lastname: 'Frankson'
                            )
      }

      context "with valid attributes" do
        it "located the requested contact" do
          patch :update, id: contact, contact: attributes_for(:contact)
          expect(assigns(:contact)).to eq contact
        end

        it "changes contact's attributes" do
          patch :update, id: contact,
            contact: attributes_for(:contact,
                                    firstname: 'Bob',
                                    lastname: 'Bobton'
                                   )
            contact.reload
            expect(contact.firstname).to eq 'Bob'
            expect(contact.lastname).to eq 'Bobton'
        end

        it "redirects to the updated contact" do
          patch :update, id: contact,
            contact: attributes_for(:contact)
          expect(response).to redirect_to contact
        end
      end

      context "with invalid attributes" do
        let(:contact) { create(:contact) }

        it "locates the requested contact" do
          patch :update, id: contact, contact: attributes_for(:invalid_contact)
          expect(assigns(:contact)).to eq(contact)
        end

        it "does not change contact's attributes" do
          patch :update, id: contact, contact: attributes_for(:contact,
                                                               firstname: 'Larry',
                                                               lastname: nil)
          expect(contact.firstname).to_not eq('Larry')
        end

        it "re-renders the edit method" do
          patch :update, id: contact, contact: attributes_for(:invalid_contact)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      let(:contact) { create(:contact) }

      it "deletes the contact" do
        contact
        expect{
          delete :destroy, id: contact
        }.to change(Contact, :count).by(-1)
      end

      it "redirects to contacts#index" do
        delete :destroy, id: contact
        expect(response).to redirect_to contacts_url
      end
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
      it "requires login" do
        get :new
        expect(response).to require_login
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, contact: attributes_for(:contact)
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it "requires login" do
        contact = create(:contact)
        patch :update, id: contact, contact: attributes_for(:contact)
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        contact = create(:contact)
        delete :destroy, id: contact
        expect(response).to require_login
      end
    end
  end
end
