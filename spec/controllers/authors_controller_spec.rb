require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe '#index' do
    subject { get :index }

    describe 'successful response' do
      before { subject }

      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end

    context 'authors' do
      let!(:author1) { create(:author) }
      let!(:author2) { create(:author) }

      it 'should return all authors' do
        subject
        expect(assigns(:authors)).to match_array([author1, author2])
      end
    end
  end

  describe '#show' do
    let(:author) { create(:author) }
    before { get :show, params: { id: author.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('show') }
    end

    context 'authors' do
      it { expect(assigns(:author)).to eq(author) }
    end
  end

  describe '#edit' do
    let(:author) { create(:author) }
    before { get :edit, params: { id: author.id } }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('edit') }
    end

    context 'authors' do
      it { expect(assigns(:author)).to eq(author) }
    end
  end

  describe '#new' do
    before { get :new }

    describe 'successful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('new') }
    end

    context 'author' do
      it { expect(assigns(:author)).to be_a(Author) }
      it { expect(assigns(:author).persisted?).to eq(false) }
    end
  end

  describe '#create' do
    let(:valid_attributes) { { author: attributes_for(:author) } }
    let(:invalid_attributes) { { author: attributes_for(:author, name: nil) } }

    context 'valid params' do
      subject { post :create, params: valid_attributes }

      it 'should redirect to authors index' do
        expect(subject).to redirect_to(authors_path)
      end

      it 'should redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should create author' do
        expect { subject }.to change { Author.count }.by(1)
      end
    end

    context 'invalid params' do
      subject { post :create, params: invalid_attributes }

      it 'should render new template' do
        expect(subject).to render_template('new')
      end

      it 'should not create author' do
        expect { subject }.not_to change { Author.count }
      end
    end
  end

  describe '#update' do
    let(:author) { create(:author) }
    let(:valid_attributes) { { id: author.id, author: attributes_for(:author, name: 'test') } }
    let(:invalid_attributes) { { id: author.id, author: attributes_for(:author, name: nil) } }

    context 'valid params' do
      subject { patch :update, params: valid_attributes }

      it 'should redirect to authors index' do
        expect(subject).to redirect_to(authors_path)
      end

      it 'should redirect with notice' do
        subject
        expect(flash[:notice]).to be_present
      end

      it 'should update author' do
        subject
        expect(author.reload.name).to eq('test')
      end
    end

    context 'invalid params' do
      subject { patch :update, params: invalid_attributes }

      it 'should render edit template' do
        expect(subject).to render_template('edit')
      end

      it 'should not create author' do
        expect { subject }.not_to change { Author.name }
      end
    end
  end

  describe '#update' do
    let(:author) { create(:author) }
    subject { delete :destroy, params: { id: author.id } }

    it 'should redirect to authors index' do
      expect(subject).to redirect_to(authors_path)
    end

    it 'should redirect with notice' do
      subject
      expect(flash[:notice]).to be_present
    end

    it 'should destroy author' do
      author
      expect { subject }.to change { Author.count }.by(-1)
    end
  end
end
