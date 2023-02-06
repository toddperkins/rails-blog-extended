require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  
  # articles#show
  describe 'GET articles#show' do
    let(:article) { FactoryBot.create(:article, :with_comments) }
    let(:params) { {id: article.id} }

    it 'displays comments' do
      get article_path(params)
      expect(article.comments).to eq(Comment.all)
    end

    it "renders the articles#show template" do
      get article_path(params)
      expect(response).to render_template("show")
    end

    it "is expected to assign new comment" do
      get article_path(params)
      expect(assigns[:comment]).to be_instance_of(Comment)
    end
  end

  # comments#create
  describe "POST #create" do
    let(:comment) { FactoryBot.create(:comment) }

    context "when params are correct" do
      let(:params) {{ article_id: comment.article.id, comment: {commenter: 'Todd Perkins', body: 'This is my sample body.'} } }

      it 'is expected to create new comment successfully' do
        post article_comments_path(params)
        expect(assigns[:comment]).to be_instance_of(Comment)
      end

      it 'is expected to create new comment successfully' do
        post article_comments_path(params)
        expect(assigns[:comment]).to be_valid
      end

      it 'is expected to have commenter assigned to it' do
        post article_comments_path(params)
        expect(assigns[:comment].commenter).to eq('Todd Perkins')
      end

      it 'is expected to redirect to article show path' do
        post article_comments_path(params)
        expect(response).to redirect_to article_path(assigns[:comment].article.id)
      end
    end

    context 'when params are invalid' do
      let(:params) {{ article_id: comment.article.id, comment: {commenter: '', body: ''} } }

      it "is expected to render the new template" do
        post article_comments_path(params)
        expect(response).to render_template("show")
      end

      it 'is expected to be invalid' do
        post article_comments_path(params)
        expect(assigns[:comment]).to_not be_valid
      end
    end
  end

  # destroy
  describe 'DELETE #destroy' do
    context 'when comment deleted successfully' do
      let(:comment) { FactoryBot.create(:comment) }
      let(:params) { {id: comment.id} }

      it 'deletes the article' do
        expect {
          delete article_comment_path(params).to change(Comment, :count).by(-1)
        }
      end
    end
  end

end