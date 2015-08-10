# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130920032911) do

  create_table "annexes", :force => true do |t|
    t.integer  "insurance_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "certificate_request_clauses", :force => true do |t|
    t.integer  "certificate_request_id"
    t.integer  "clause_id"
    t.boolean  "is_included"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "is_fixed",               :default => false
  end

  add_index "certificate_request_clauses", ["certificate_request_id"], :name => "index_certificate_request_clauses_on_certificate_request_id"
  add_index "certificate_request_clauses", ["clause_id"], :name => "index_certificate_request_clauses_on_clause_id"

  create_table "certificate_request_coverages", :force => true do |t|
    t.integer  "certificate_request_id"
    t.integer  "coverage_id"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.boolean  "incluir",                                              :default => false
    t.decimal  "deductible",             :precision => 4, :scale => 2, :default => 0.0
  end

  add_index "certificate_request_coverages", ["certificate_request_id"], :name => "index_certificate_request_coverages_on_certificate_request_id"
  add_index "certificate_request_coverages", ["coverage_id"], :name => "index_certificate_request_coverages_on_coverage_id"

  create_table "certificate_requests", :force => true do |t|
    t.string   "num_constancia"
    t.string   "nombre"
    t.string   "direccion"
    t.integer  "city_id"
    t.string   "cp",                     :limit => 10
    t.string   "rfc",                    :limit => 15
    t.date     "fecha_salida"
    t.date     "fecha_llegada"
    t.decimal  "importe",                              :precision => 12, :scale => 2, :default => 0.0
    t.string   "moneda",                 :limit => 1
    t.string   "beneficiario"
    t.text     "deducibles"
    t.text     "medida_seguridad"
    t.datetime "created_at",                                                                             :null => false
    t.datetime "updated_at",                                                                             :null => false
    t.integer  "possession_id"
    t.string   "codigo_seguridad"
    t.integer  "status",                                                              :default => 1
    t.boolean  "cancelado",                                                           :default => false
    t.integer  "user_id"
    t.integer  "policy_id"
    t.boolean  "use_beneficiario",                                                    :default => false
    t.integer  "city_from_id"
    t.integer  "city_to_id"
    t.string   "possession_description"
    t.string   "packaging"
    t.boolean  "same_city",                                                           :default => false
    t.string   "num_invoice",            :limit => 50
    t.decimal  "base_fee",                             :precision => 4,  :scale => 2, :default => 0.0
    t.decimal  "expedition_fee",                       :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "iva",                                  :precision => 4,  :scale => 2, :default => 0.0
    t.decimal  "iva_amount",                           :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "total_prime",                          :precision => 12, :scale => 2, :default => 0.0
    t.date     "emission_date"
    t.boolean  "transport_ground",                                                    :default => false
    t.boolean  "transport_air",                                                       :default => false
    t.boolean  "transport_maritime",                                                  :default => false
    t.boolean  "transport_rail",                                                      :default => false
    t.boolean  "transport_package",                                                   :default => false
    t.date     "canceled_at"
  end

  add_index "certificate_requests", ["canceled_at"], :name => "ak_fecha_cancelacion"
  add_index "certificate_requests", ["city_from_id"], :name => "fk_city_from"
  add_index "certificate_requests", ["city_id"], :name => "fk_ciudad"
  add_index "certificate_requests", ["city_to_id"], :name => "fk_city_to"
  add_index "certificate_requests", ["emission_date"], :name => "ak_fecha_emision"
  add_index "certificate_requests", ["fecha_llegada"], :name => "ak_fecha_llegada"
  add_index "certificate_requests", ["fecha_salida"], :name => "ak_fecha_salida"
  add_index "certificate_requests", ["nombre"], :name => "ak_nombre"
  add_index "certificate_requests", ["num_constancia"], :name => "ak_num_constancia"
  add_index "certificate_requests", ["possession_id"], :name => "fk_possession"

  create_table "certificate_requests_transportations", :id => false, :force => true do |t|
    t.integer "certificate_request_id"
    t.integer "transportation_id"
  end

  add_index "certificate_requests_transportations", ["certificate_request_id", "transportation_id"], :name => "index_cert_request_id_transportation_id"

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cities", ["state_id"], :name => "index_cities_on_state_id"

  create_table "clauses", :force => true do |t|
    t.string   "name"
    t.boolean  "isfixed",    :default => false
    t.boolean  "active",     :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "clauses_transportations", :id => false, :force => true do |t|
    t.integer "clause_id"
    t.integer "transportation_id"
  end

  add_index "clauses_transportations", ["clause_id", "transportation_id"], :name => "index_clauses_transportations_on_clause_id_and_transportation_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "coverages", :force => true do |t|
    t.text     "name"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.boolean  "active",                                       :default => true
    t.decimal  "deductible_min", :precision => 4, :scale => 2, :default => 0.0
    t.integer  "insurance_id"
  end

  create_table "general_settings", :force => true do |t|
    t.decimal  "iva",                       :precision => 4, :scale => 2
    t.decimal  "base_fee_min",              :precision => 4, :scale => 2
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
    t.string   "packaging_default"
    t.decimal  "exchange_usd",              :precision => 8, :scale => 2, :default => 0.0
    t.text     "medidas_seguridad_default"
    t.text     "deducible_default"
    t.integer  "certificate_consecutive",                                 :default => 0
  end

  create_table "insurance_coverages", :force => true do |t|
    t.integer  "insurance_id"
    t.integer  "coverage_id"
    t.decimal  "deductible_min", :precision => 4, :scale => 2
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "insurance_coverages", ["coverage_id"], :name => "fk_coverage_insurance_coverage"
  add_index "insurance_coverages", ["insurance_id"], :name => "fk_insurance_insurance_coverage"

  create_table "insurance_possessions", :force => true do |t|
    t.integer  "insurance_id"
    t.integer  "possession_id"
    t.boolean  "has_max_amount",                                :default => false
    t.decimal  "max_amount",     :precision => 12, :scale => 2
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  add_index "insurance_possessions", ["insurance_id"], :name => "fk_insurance_insurance_possession"
  add_index "insurance_possessions", ["possession_id"], :name => "fk_possession_insurance_possession"

  create_table "insurances", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.decimal  "expedition_fee_mx",   :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "expedition_fee_us",   :precision => 8,  :scale => 2, :default => 0.0
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "firma1_file_name"
    t.string   "firma1_content_type"
    t.integer  "firma1_file_size"
    t.datetime "firma1_updated_at"
    t.string   "firma2_file_name"
    t.string   "firma2_content_type"
    t.integer  "firma2_file_size"
    t.datetime "firma2_updated_at"
    t.text     "deductible_text"
    t.decimal  "max_amount",          :precision => 12, :scale => 2, :default => 0.0
    t.string   "tin"
    t.string   "street"
    t.string   "area"
    t.integer  "city_id"
    t.string   "zip_code"
  end

  create_table "policies", :force => true do |t|
    t.string   "folio",        :limit => 50
    t.string   "moneda",       :limit => 1
    t.integer  "insurance_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.date     "date_start"
    t.date     "date_end"
  end

  add_index "policies", ["insurance_id"], :name => "index_policies_on_insurance_id"

  create_table "possessions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.boolean  "active",                                        :default => true
    t.boolean  "has_max_amount",                                :default => false
    t.decimal  "max_amount",     :precision => 12, :scale => 2, :default => 0.0
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "permalink"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "country_id"
  end

  create_table "transportations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "role_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
