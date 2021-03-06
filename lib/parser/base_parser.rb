module Parser
  class BaseParser
    def initialize(document)
      @document = document
      @ids = []
      @association_attributes = {
        school_branch_id:  @document.school_branch_id,
        creator_type:  @document.creator_type,
        creator_id:  @document.creator_id,
        document_id: @document.id
      }
    end

    def parse
      parse_csv document_path
      update_document
    end

    protected

    def update_document
      @document.recorded_ids = @ids
      @document.save
    end

    def document_path
      Rails.root.to_s + "/public" + @document.name.url
    end

  end
end
