require 'rails_helper'

RSpec.shared_context 'already exist an article' do

  let(:article) do
    Article.create(title: 'Test title',
                   body: 'Test example body',
                   status: VisibleFeature::PUBLIC,
                   user: @user) # Param user has to be the same than the logged user, for allowing modifications
  end

  include_context 'articles indexation'
  include_context 'articles edition'
  include_context 'articles deletion'
end

RSpec.shared_context 'doesn\'t exist an article yet' do
  include_context 'articles creation'
end

RSpec.shared_context 'articles indexation' do

  it 'render the articles index template' do
    get(:index)
    expect(response).to have_http_status(200)
    expect(response).to render_template('layouts/application', :articles)
  end

  it 'can be shown' do
    get(:show, params: { id: article.id })
    expect(response).to have_http_status(200)
    expect(response).to render_template('layouts/application', :show)
  end

end

RSpec.shared_context 'articles creation' do
  it 'render the articles :new template' do
    get(:new)
    expect(response).to render_template('layouts/application', :new)
  end

  it 'create a new article using the :create post endpoint' do
    post :create,
         params: {
           article:
             { title: 'Test title',
               body: 'Test example body',
               status: VisibleFeature::PUBLIC,
               user: @user }
         }

    expect(response).to have_http_status(302)
    expect(Article.all).not_to be_empty
  end
end

##########################################################

RSpec.shared_context 'articles edition' do

  it 'render the articles :edit template' do
    get :edit, params: { id: article.id }
    expect(response).to render_template('layouts/application', article)
  end

  it 'edits an existing article using the :update put endpoint' do
    put :update,
        params: {
          id: article.id,
          article:
            { title: 'New test title',
              body: 'new test example body',
              status: VisibleFeature::PERSONAL,
              user: @user }
        }

    expect(response).to have_http_status(302)
    expect(response).to redirect_to(article)
    expect(Article.last).not_to be_equals(article)
  end
end

RSpec.shared_context 'articles deletion' do

  it 'deletes an existing article using the :destroy delete endpoint' do

    post :destroy,
         params: {
           id: article.id
         }

    expect(response).to have_http_status(302)
    expect(response).to redirect_to(articles_path)
    expect { Article.find(article.id) }.to raise_error ActiveRecord::RecordNotFound
  end
end

##########################################################

RSpec.describe ArticlesController, type: :controller do

  context 'when user is no logged in' do
    it 'redirect to the login template' do
      get(:index)
      expect(response).to redirect_to('/login')
    end
  end

  context 'when user is logged in' do

    # When before(:context) the session scope is lost on the subsequent calls so it throws an exception
    before(:example) { @user = logged_user }

    include_context 'already exist an article'
    include_context 'doesn\'t exist an article yet'

  end
end
