class CreateNoraSecureTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :nora_secure_tokens do |t|
      t.references :nora_user, foreign_key: true, null: false
      t.string :token, limit: 40, null: false

      t.timestamps
    end
  end
end
