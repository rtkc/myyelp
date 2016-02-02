class CreateTableUsers < ActiveRecord::Migration
  def change
    create_table :table_users do |t|
      t.string :full_name, :email, :password_digest
      t.timestamps
    end
  end
end
