require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # Test relationships
  should have_many(:book_authors)
  should have_many(:authors).through(:book_authors)
  should belong_to(:publisher)
  
  # Test validations
  should validate_presence_of(:title)
  should allow_value("1234567890").for(:isbn)
  should allow_value(nil).for(:isbn)
  should_not allow_value("123456789012").for(:isbn)
  should_not allow_value("123456789").for(:isbn)
  should allow_value(1986).for(:year_published)
  should allow_value(2011).for(:year_published)
  should_not allow_value("bad").for(:year_published)
  should_not allow_value(2011.3).for(:year_published)
  
  # Test scopes within a context
  context "Creating three books by two authors" do
    # create the objects I want with factories
    setup do 
      @ingomar = Factory.create(:publisher)
      @westview = Factory.create(:publisher, :name => "Westview Press")
      @shakespeare = Factory.create(:author)
      @austen = Factory.create(:author, :first_name => "Jane", :last_name => "Austen")
      @hamlet = Factory.create(:book, :publisher => @ingomar)
      @macbeth = Factory.create(:book, :title => "Macbeth", :year_published => 2002, :publisher => @westview)
      @pride = Factory.create(:book, :title => "Pride and Prejudice", :year_published => 2009, :publisher => @ingomar)
      @ba1 = Factory.create(:book_author, :book => @hamlet, :author => @shakespeare)
      @ba2 = Factory.create(:book_author, :book => @macbeth, :author => @shakespeare)
      @ba3 = Factory.create(:book_author, :book => @pride, :author => @austen)
    end
    
    # and provide a teardown method as well
    teardown do
      @ingomar.destroy
      @westview.destroy
      @shakespeare.destroy
      @austen.destroy
      @hamlet.destroy
      @macbeth.destroy
      @pride.destroy
      @ba1.destroy
      @ba2.destroy
      @ba3.destroy
    end
  
    # now run the tests:
    # test one of each factory (not really required, but not a bad idea)
    should "show that all factories are properly created" do
      assert_equal "Ingomar Heights Press", @ingomar.name
      assert_equal "William", @shakespeare.first_name
      assert_equal "Jane", @austen.first_name
      assert_equal "Hamlet", @hamlet.title
      assert_equal "Shakespeare", @macbeth.authors.first.last_name
      assert_equal 2009, @pride.year_published
    end
    
    should "list all books in alphabetical order" do
      assert_equal %w[Hamlet Macbeth Pride\ and\ Prejudice], Book.all.map{|b| b.title}
    end
    
    should "list all books published before a given year" do
      assert_equal %w[Hamlet Macbeth], Book.before(2005).map{|b| b.title}
    end
    
    should "list all books published since a given year" do
      assert_equal %w[Pride\ and\ Prejudice], Book.since(2005).map{|b| b.title}
    end
    
    should "list all books for a given publisher" do
      assert_equal %w[Hamlet Pride\ and\ Prejudice], Book.for_publisher(@ingomar.id).map{|b| b.title}
      assert_equal %w[Macbeth], Book.for_publisher(@westview.id).map{|b| b.title}
    end
    
    should "list all books for a given author" do
      assert_equal %w[Hamlet Macbeth], Book.for_author(@shakespeare.id).map{|b| b.title}
    end
    
  end
end
