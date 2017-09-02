class CreateNoraRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :nora_repositories do |t|
      t.string :name, limit: 100, null: false
      t.string :url, limit: 200, null: false

      t.timestamps
    end
  end
end
