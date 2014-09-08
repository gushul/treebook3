class UpdateStatusDocumentRelation < ActiveRecord::Migration
  def change
    add_column :documents, :status_id, :integer
    remove_column :statuses, :document_id
  end
end
