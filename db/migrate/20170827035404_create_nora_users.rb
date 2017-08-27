class CreateNoraUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :nora_users do |t|
      t.string :provider, limit: 20, null: false
      t.string :uid, limit: 40, null: false
      t.string :name, limit: 50, null: false

      t.timestamps
    end

    add_index 'nora_users', %w[provider uid], name: 'tokite_user_uniq_provider_uid', unique: true, using: :btree
  end
end
