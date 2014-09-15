module Parser

  class StudentParser < BaseParser

    def initialize(document)
      super
      @school_branch_id = @document.school_branch_id
      @class_rooms = {}
    end

    private

    def parse_csv(path)
      CSV.foreach(path, headers: true) do |row|
        create_student row.to_h
      end
    end

    def create_student(row)
      student = Student.new with_student_attributes(row)

      if student.save && student.create_class_room_student
        @ids << student.id
      else
        student.destroy if student.persisted?
        false
      end
    end

    def with_student_attributes(row)
      {
        name: row["name"],
        roll_number: row["roll_number"],
        class_room_id: get_class_room_id(row),
        year: row["year"]
      }.merge(@association_attributes)
    end

    def get_class_room_id(row)
      @class_rooms["#{@school_branch_id}-#{row["class"]}-#{row["section"]}"] ||= {}

      if @class_rooms["#{@school_branch_id}-#{row["class"]}-#{row["section"]}"]["is_set"]
        @class_rooms["#{@school_branch_id}-#{row["class"]}-#{row["section"]}"]["id"]
      else
        @class_rooms["#{@school_branch_id}-#{row["class"]}-#{row["section"]}"]["is_set"] = true
        @class_rooms["#{@school_branch_id}-#{row["class"]}-#{row["section"]}"]["id"] =
          ClassRoom.where(
              school_branch_id: @school_branch_id,
              name: row["class"],
              grade: row["section"]
            ).first.try(:id)
      end
    end

  end

end