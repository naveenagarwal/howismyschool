class Document < ActiveRecord::Base
  TYPES = [ "ClassRoom", "ClassTest", "Student", "Subject" ]

  mount_uploader :name, DocumentUploader

  belongs_to :creator, polymorphic: true
  belongs_to :school_branch

  has_many :class_rooms, dependent: :destroy
  has_many :class_tests, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :subjects, dependent: :destroy


  before_validation :validate_document_type

  validates :name, presence: true

  class << self

    def document_types_array_for_select_option
      Document::TYPES.map do |type|
        titlecase_type = type.titleize
        [ titlecase_type, titlecase_type ]
      end
    end

  end

  private

  def validate_document_type
    type = document_type.to_s.gsub(/\s/, "_").camelize

    unless TYPES.include?(type)
      self.erros.add(:document_type, "~Please select document type from the one of the drop down")
    end
  end

end
