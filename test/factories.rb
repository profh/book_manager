
# FACTORIES FOR PATS 
# -------------------------------
# Create factory for Publisher class
  Factory.define :publisher do |p|
    p.name "Ingomar Heights Press"
  end
  
# Create factory for Book class
  Factory.define :book do |b|
    b.title "Hamlet"
    b.year_published 2003
    b.isbn "1234567890"
    b.association :publisher
  end

# Create factory for Author class
  Factory.define :author do |a|
    a.first_name "William"
    a.last_name "Shakespeare"
  end
    
# Create factory for BookAuthor class
  Factory.define :book_author do |ba|
    ba.association :book
    ba.association :author
  end
