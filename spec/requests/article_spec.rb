require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  
  describe "GET #index" do

    it "assigns @articles" do
      article = Article.create
      get '/articles'
      expect(assigns(:articles)).to eq(Article.all)
    end

    it "renders the index template" do
      get '/articles'
      expect(response).to render_template("index")
    end

  end

end
