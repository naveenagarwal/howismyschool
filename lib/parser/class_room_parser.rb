module Parser

  class ClassRoomParser < BaseParser

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

  end

end