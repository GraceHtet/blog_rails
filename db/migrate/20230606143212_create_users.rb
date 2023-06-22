class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo, default: 'https://img.uxwing.com/wp-content/themes/uxwing/download/peoples-avatars-thoughts/corporate-user-icon.svg'
      t.string :bio
      t.integer :posts_counter, default: 0

      t.timestamps
    end
  end
end
