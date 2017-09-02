# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_170_902_121_551) do
  create_table 'nora_repositories', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.string 'name', limit: 100, null: false
    t.string 'url', limit: 200, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'nora_secure_tokens', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.bigint 'nora_user_id', null: false
    t.string 'token', limit: 40, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['nora_user_id'], name: 'index_nora_secure_tokens_on_nora_user_id'
  end

  create_table 'nora_users', force: :cascade, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
    t.string 'provider', limit: 20, null: false
    t.string 'uid', limit: 40, null: false
    t.string 'name', limit: 50, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[provider uid], name: 'nora_user_uniq_provider_uid', unique: true
  end

  add_foreign_key 'nora_secure_tokens', 'nora_users'
end
