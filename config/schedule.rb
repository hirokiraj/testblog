every :sunday, at: '3am' do
  runner 'Author.delete_old_authors'
end
