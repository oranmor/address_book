describe ContactsController, type: :controller do
  let(:contact) { create(:contact) }

  describe 'GET #index' do
    it 'populates an array of contacts' do
      get :index
      expect(assigns(:contacts)).to eq([contact])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'assigns the requested contact to @contact' do
      get :show, id: contact
      expect(assigns(:contact)).to eq(contact)
    end

    it 'renders the #show view' do
      get :show, id: contact
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns new contact' do
      get :new
      expect(assigns(:contact)).to be_a_new(Contact)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new contact' do
        expect { post :create, contact: attributes_for(:contact) }.to change(Contact, :count).by(1)
      end

      it 'redirects to the new contact' do
        post :create, contact: attributes_for(:contact)
        expect(response).to redirect_to Contact.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new contact' do
        expect { post :create, contact: attributes_for(:contact, :invalid) }.to_not change(Contact, :count)
      end

      it 're-renders the new method' do
        post :create, contact: attributes_for(:contact, :invalid)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    context 'valid attributes' do
      it 'located the requested @contact' do
        put :update, id: contact, contact: attributes_for(:contact)
        expect(assigns(:contact)).to eq(contact)
      end

      it "changes @contact's attributes" do
        put :update, id: contact, contact: attributes_for(:contact, first_name: 'Larry', last_name: 'Smith')
        contact.reload
        expect(contact.first_name).to eq('Larry')
        expect(contact.last_name).to eq('Smith')
      end

      it 'redirects to the updated contact' do
        put :update, id: contact, contact: attributes_for(:contact)
        expect(response).to redirect_to contact
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @contact' do
        put :update, id: contact, contact: attributes_for(:contact, :invalid)
        expect(assigns(:contact)).to eq(contact)
      end

      it "does not change @contact's attributes" do
        put :update, id: contact, contact: attributes_for(:contact, first_name: 'Larry', last_name: nil)
        contact.reload
        expect(contact.first_name).to_not eq('Larry')
        expect(contact.last_name).to_not be_nil
      end

      it 're-renders the edit method' do
        put :update, id: contact, contact: attributes_for(:contact, :invalid)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:contact) { create(:contact) }
    it 'deletes the contact' do
      expect { delete :destroy, id: contact }.to change(Contact, :count).by(-1)
    end

    it 'redirects to contacts#index' do
      delete :destroy, id: contact
      expect(response).to redirect_to contacts_url
    end
  end

  describe 'PUT share' do
    it 'call ContactSharingMailer' do
      message_delivery = instance_double(ActionMailer::MessageDelivery)
      expect(ContactSharingMailer).to receive(:share_contact).and_return(message_delivery)
      expect(message_delivery).to receive(:deliver_later)
      put :share, id: contact, email: Faker::Internet.email
    end
  end

  describe 'POST import' do
    it 'call ContactCsvImport' do
      expect(ContactCsvService).to receive(:import_from_csv)
      post :import, file: fixture_file_upload('contacts.csv')
    end
  end
end
