class AddCredencialsToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :author, :string
    add_column :books, :edition, :string
    add_column :books, :type_book, :string
  end
end
