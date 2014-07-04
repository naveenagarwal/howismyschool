module Parser

  class ClassRoomParser < BaseParser

    def initialize(document)
      @document = document
      @ids = []
      @association_attributes = {
        school_branch_id:  @document.school_branch_id,
        creator_type:  @document.creator_type,
        creator_id:  @document.creator_id
      }
    end

    def parse
      parse_csv document_path
      update_document
    end

    private

    def parse_csv(path)
      CSV.foreach(path, headers: true) do |row|
        create_class_room row.to_h
      end
    end

    def create_class_room(row)
      class_room = ClassRoom.new row.merge(@association_attributes)

      if class_room.save
        @ids << class_room.id
      else
        false
      end
    end

    def update_document
      @document.recorded_ids = @ids
      @document.save
    end

    def document_path
      Rails.root.to_s + "/public" + @document.name.url
    end

  end

end