class AddDocumentReferenceToMultipleModels < ActiveRecord::Migration
  def change
    add_reference :class_rooms, :document, index: true
    add_reference :class_tests, :document, index: true
    add_reference :students, :document, index: true
    add_reference :subjects, :document, index: true
  end
end
