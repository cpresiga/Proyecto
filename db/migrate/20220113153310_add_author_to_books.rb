class AddAuthorToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :author_first_name, :string
    add_column :books, :author_last_name, :string
    add_column :books, :author_email, :string
    add_column :books, :author_job_title, :string
  end
end
