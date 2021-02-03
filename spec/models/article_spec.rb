require 'rails_helper'

RSpec.describe Article, type: :model do

  # Fake pool
  let(:user) { User.create(username: "dummy", password: "dummy") } # Warning!, it has to exist a way of mocking this!!
  # let(:user) { instance_double(User) } Doesn't work!
  let(:title) { 'Some generic title' }
  let(:body) { 'Some generic body' }
  let(:status) { %w[public personal archived].sample }
  let(:article) { Article.new }

  context 'on the transactional stuff' do
    let(:article) { Article.new(title: title, body: body, status: status, user: user) }

    it 'can be instantiated' do
      expect { Article.new }.not_to raise_error
    end

    it 'can be saved' do
      expect(article.save).not_to be_falsey
    end
  end

  context 'has a body' do
    let(:article) { Article.new(title: title, body: body, status: status, user: user) }

    it 'should be able to read that body' do
      article.save
      expect(article.body).to eq(body)
    end

    context 'should be able to save that body' do

      let(:long_body_example) { 'Example full length body' }
      let(:short_body_example) { 'Short' }
      let(:article) { Article.new(title: title, status: status, user: user) }

      it 'fails when the body does not match the length' do
        article.body = short_body_example
        expect(article.save).to be_falsey
      end

      it 'asserts when its body matches the length' do
        article.body = long_body_example
        expect(article.save).to be_truthy
      end

    end
  end
end
