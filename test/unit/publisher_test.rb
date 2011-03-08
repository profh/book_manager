require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  should have_many(:books)
  should validate_presence_of(:name)
end
