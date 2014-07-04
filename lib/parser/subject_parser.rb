module Parser

  class SubjectParser < BaseParser

    private

    def parse_csv(path)
      CSV.foreach(path, headers: true) do |row|
        create_subject row.to_h
      end
    end

    def create_subject(row)
      subject = Subject.new row.merge(@association_attributes)

      if subject.save
        @ids << subject.id
      else
        false
      end
    end

  end

end