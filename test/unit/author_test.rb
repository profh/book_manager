require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  # Test relationships
  should have_many(:book_authors)
  should have_many(:books).through(:book_authors)
  
  # Test validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  
end
