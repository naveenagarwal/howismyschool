module Parser

  class ClassTestParser < BaseParser

    private

    def parse_csv(path)
      CSV.foreach(path, headers: true) do |row|
        create_class_test row.to_h
      end
    end

    def create_class_test(row)
      class_test = ClassTest.new row.merge(@association_attributes)

      if class_test.save
        @ids << class_test.id
      else
        false
      end
    end
  end

end