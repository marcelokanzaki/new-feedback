# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_26_192605) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "hstore"
  enable_extension "plpgsql"
  enable_extension "tablefunc"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "agencias", id: :integer, default: nil, force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "longitude", limit: 255
    t.string "latitude", limit: 255
    t.date "data_de_abertura"
    t.string "endereco"
    t.integer "rede_id"
  end

  create_table "aplicativos", id: :serial, force: :cascade do |t|
    t.string "nome"
    t.string "url"
    t.string "icone"
    t.boolean "icone_borda", default: false
    t.boolean "ativo", default: true
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "restrito", default: false, null: false
    t.index ["url"], name: "index_aplicativos_on_url", unique: true
  end

  create_table "avaliacoes", force: :cascade do |t|
    t.integer "responsabilidade"
    t.integer "comprometimento"
    t.integer "produtividade"
    t.integer "atendimento_humanizado"
    t.bigint "participacao_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participacao_id"], name: "index_avaliacoes_on_participacao_id"
  end

  create_table "ciclos", force: :cascade do |t|
    t.string "nome", default: "", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "quantidade_de_feedbacks", default: 1, null: false
    t.integer "status", default: 0, null: false
    t.date "inicio"
    t.date "fim"
  end

  create_table "clientes", id: :integer, default: nil, force: :cascade do |t|
    t.string "nome"
    t.integer "tipo_pessoa"
    t.string "documento"
    t.integer "agencia_id"
    t.boolean "cooperado"
    t.date "cooperado_desde"
    t.string "ramo_atividade"
    t.date "data_atualizacao_cadastro"
    t.date "data_renovacao"
    t.decimal "total_renda", precision: 20, scale: 2
    t.string "nucleo"
    t.string "risco_id"
    t.date "data_referencia"
    t.date "data_nascimento"
    t.string "gerente"
    t.string "email"
    t.string "cidade"
    t.date "entrada_utilizacao_de_limite"
    t.date "entrada_em_adiantamento"
    t.date "vencimento_proxima_parcela"
    t.date "vencimento_cartao"
  end

  create_table "equipes", force: :cascade do |t|
    t.bigint "ciclo_id", null: false
    t.string "nome", default: "", null: false
    t.integer "avaliador_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "padrinho_id"
    t.boolean "concluida", default: false, null: false
    t.index ["ciclo_id"], name: "index_equipes_on_ciclo_id"
    t.index ["padrinho_id"], name: "index_equipes_on_padrinho_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "participacao_id"
    t.text "mensagem", default: "", null: false
    t.integer "autor_id", null: false
    t.boolean "aprovado", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "presencial"
    t.boolean "possivel_copia", default: false, null: false
    t.index ["participacao_id"], name: "index_feedbacks_on_participacao_id"
  end

  create_table "notas", force: :cascade do |t|
    t.bigint "participante_id", null: false
    t.bigint "avaliador_id", null: false
    t.text "conteudo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avaliador_id"], name: "index_notas_on_avaliador_id"
    t.index ["participante_id"], name: "index_notas_on_participante_id"
  end

  create_table "notificacoes", id: :serial, force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.text "mensagem", null: false
    t.string "url", default: "", null: false
    t.string "imagem_url", default: "", null: false
    t.boolean "vista", default: false, null: false
    t.boolean "aberta", default: false, null: false
    t.string "object_uuid"
    t.string "app", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["usuario_id"], name: "index_notificacoes_on_usuario_id"
  end

  create_table "participacoes", force: :cascade do |t|
    t.bigint "equipe_id"
    t.integer "participante_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "avatar_id"
    t.string "avatar_filename"
    t.integer "avatar_size"
    t.string "avatar_content_type"
    t.boolean "avatar_aprovado", default: false, null: false
    t.boolean "concluida", default: false, null: false
    t.integer "agencia_id", null: false
    t.boolean "com_copia", default: false, null: false
    t.index ["equipe_id"], name: "index_participacoes_on_equipe_id"
  end

  create_table "permissoes", id: :serial, force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.integer "responsavel_id", null: false
    t.string "app", null: false
    t.string "namespace", default: "admin", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "renovacoes_de_seguros", id: :serial, force: :cascade do |t|
    t.string "segurado_nome"
    t.integer "agencia_id"
    t.text "hash_value", null: false
    t.string "telefone"
    t.integer "proposta"
    t.string "seguradora"
    t.string "documento"
    t.date "vigencia"
    t.integer "card_id"
  end

  create_table "renovacoes_de_seguros_atualizacao", id: :serial, force: :cascade do |t|
    t.string "segurado_nome"
    t.integer "agencia_id"
    t.text "hash_value"
    t.string "telefone"
    t.integer "proposta"
    t.string "seguradora"
    t.string "documento"
    t.date "vigencia"
    t.string "apolice"
  end

  create_table "telefones", id: :serial, force: :cascade do |t|
    t.integer "cliente_id", null: false
    t.string "ddd", null: false
    t.string "numero", null: false
    t.integer "tipo", null: false
    t.index ["cliente_id"], name: "index_public.telefones_on_cliente_id"
  end

  create_table "usuarios", id: :serial, force: :cascade do |t|
    t.string "nome"
    t.string "email", default: "", null: false
    t.string "avatar"
    t.integer "agencia_id"
    t.boolean "ativo", default: true
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "cpf", default: ""
    t.date "data_de_desligamento"
    t.boolean "habilitar_depoimentos", default: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "avaliacoes", "participacoes"
  add_foreign_key "equipes", "usuarios", column: "padrinho_id"
  add_foreign_key "feedbacks", "participacoes"
  add_foreign_key "notas", "usuarios", column: "avaliador_id"
  add_foreign_key "notas", "usuarios", column: "participante_id"
  add_foreign_key "participacoes", "equipes"
  add_foreign_key "telefones", "clientes"
end
