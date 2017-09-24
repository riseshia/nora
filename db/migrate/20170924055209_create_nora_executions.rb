class CreateNoraExecutions < ActiveRecord::Migration[5.1]
  def change
    create_table :nora_executions do |t|
      t.integer :nora_repository_id, null: false
      t.integer :pull_request_id, null: false
      t.string :base, null: false, limit: 128
      t.string :compare, null: false, limit: 128
      t.boolean :completed, null: false, default: false
      t.text :result

      t.timestamps
    end
    add_index :nora_executions, :nora_repository_id
  end
end
