class TimeExt < Time
  def self.current_year
    @current_year ||= if now.month.between? 4, 12
        "#{now.year}-#{now.year + 1}"
      else
        "#{now.year - 1}-#{now.year}"
      end
  end
end