require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  it 'doesn\'t render the articles index template if not logged in' do
    expect(response).not_to render_template('articles')
  end

  # TODO
  # context 'when logged in' do
  #   before(:context) do
  #   end
  #   it 'render the articles index template if logged in' do
  #     Login.
  #       expect(response).to render_template("articles")
  #   end
  # end

end
