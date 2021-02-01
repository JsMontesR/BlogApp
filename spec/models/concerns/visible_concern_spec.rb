require 'rails_helper'

RSpec.describe Article, type: :module do
  let(:user) { User.create(username: 'dummy', password: 'dummy') } # Warning!, it has to exist a way of mocking this!!
  let(:title) { 'Some generic title' }
  let(:body) { 'Some generic body' }
  let(:status) { %w[public personal archived].sample }
  let(:article) { Article.new(title: title, body: body, status: status, user: user) }
  it 'status can be verified' do
    expect { article.archived? }.not_to raise_error
    expect { article.public? }.not_to raise_error
    expect { article.personal? }.not_to raise_error
    # This test could be better if create a Dummy model who includes the Visible concern instead of using a real model,
    # violating the principle of isolation for unit tests
  end
end
