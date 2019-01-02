class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :f_name
      t.string :l_name
      t.string :password_digest
      t.timestamps
    end
  end
end
