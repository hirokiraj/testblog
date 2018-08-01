class RemoveOldAuthors < ApplicationJob
  queue_as :default

  def perform(*args)
    Author.old.destroy_all
  end
end
