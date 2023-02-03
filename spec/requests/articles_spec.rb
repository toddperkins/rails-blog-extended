require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  
  # index  
  describe "GET #index" do
    it "assigns @articles" do
      article = Article.create
      get articles_path
      expect(assigns(:articles)).to eq(Article.all)
    end

    it "renders the index template" do
      get articles_path
      expect(response).to render_template("index")
    end
  end

  # new
  describe "GET #new" do
    it "is expected to assign new article" do
      get new_article_path
      expect(assigns[:article]).to be_instance_of(Article)
    end

    it "is expected to render the new template" do
      get new_article_path
      expect(response).to render_template("new")
    end
  end

  # create
  describe "POST #create" do
    context "when params are correct" do
      let(:params) {{ article: {title: 'My Title', body: 'This is my sample body that is valid.'} }}

      it 'is expected to create new user successfully' do
        post articles_path, params: params
        expect(assigns[:article]).to be_instance_of(Article)
      end

      it 'is expected to have title assigned to it' do
        post articles_path, params: params
        expect(assigns[:article].title).to eq('My Title')
      end

      it 'is expected to redirect to articles path' do
        post articles_path, params: params
        expect(response).to redirect_to article_path(assigns[:article].id)
      end

      it 'is expected to be valid' do
        post articles_path, params: params
        expect(assigns[:article]).to be_valid
      end
    end

    context 'when params are not correct' do
      let(:params) {{ article: {title: ''} }}

      it "is expected to render the new template" do
        post articles_path, params: params
        expect(response).to render_template("new")
      end

      it 'is expected to be invalid' do
        post articles_path, params: params
        expect(assigns[:article]).to_not be_valid
      end
    end
  end

  # edit
  describe 'GET #edit' do
    context 'when article id is valid' do
      let(:article) { FactoryBot.create(:article) }
      let(:params) { {id: article.id} }

      it 'is expected to set article instance variable' do
        get edit_article_path(params)
        expect(assigns[:article]).to eq(Article.find_by(id: params[:id]))
      end

      it 'is expected to render edit template' do
        get edit_article_path(params)
        expect(response).to render_template("edit")
      end
    end

    context 'when article id is invalid' do
      let(:params) { { id: Faker::Number.number } }

      it 'is expected to redirect_to articles path' do
        get edit_article_path(params)
        expect(response).to redirect_to(articles_path)
      end
    end
  end

  # update
  describe 'PATCH #update' do
    before do
      patch article_path(params)
    end

    context 'when article not found' do
      let(:params) { {id: Faker::Number.number} }

      it 'is expected to redirect_to articles path' do
        expect(response).to redirect_to(articles_path)
      end
    end

    context 'when article is found' do
      let(:article) { FactoryBot.create :article }
      let(:params) { { id: article.id, article: { title: 'Test title' } } }

      context 'when data provided is valid' do
        it 'is expected to update article' do
          expect(article.reload.title).to eq('Test title')
        end

        it 'is expected to redirect to articles_path' do
          expect(response).to redirect_to(article_path)
        end
      end

      context 'when data provided is invalid' do
        let(:article) { FactoryBot.create :article }
        let(:params) { { id: article.id, article: { title: '' } } }

        it 'is expected not to update article title' do
          expect(article.reload.title).not_to be_empty
        end

        it 'is expected to render edit template' do
          expect(response).to render_template('edit')
        end

        it 'is expected to add errors to article' do
          expect(assigns[:article].errors.any?).to eq(true)
        end
      end
    end
  end

  # destroy
  describe 'DELETE #destroy' do
    context 'when article deleted successfully' do
      let(:article) { FactoryBot.create(:article) }
      let(:params) { {id: article.id} }

      it 'deletes the article' do
        expect {
          delete article_path(params).to change(Article, :count).by(-1)
        }
      end
    end
  end

end
