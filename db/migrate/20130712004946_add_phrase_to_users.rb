class AddPhraseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phrase, :string
  end
end
