class Schedule < ActiveRecord::Base

  EVENT_FOR = [ "Class Room" ]

  belongs_to :creator, polymorphic: true
  belongs_to :school_branch

  validates :title, :start_time, :end_time, :event_for, :school_branch_id, presence: true

  before_save :ensure_event_for_is_set

  validates_with MinMaxValidator,
    fields: { min: :start_time, max: :end_time, msg: "Invalid date!" }

  class << self

    def events(month: nil, year: nil, current_school_branch_id: nil)
      events_hash = {}
      start_time = "#{month}/#{year}".to_datetime.beginning_of_month
      end_time = start_time.end_of_month

      select(
          "distinct on(start_time) start_time"
        ).where(
        [
          "school_branch_id = ? AND \
          start_time >= ? ANd \
          start_time <= ?",
          current_school_branch_id, start_time, end_time
        ]
      ).each do |schedule|
        names = where(start_time: schedule.start_time.beginning_of_day..schedule.start_time.end_of_day).first(3).map(&:title) + ["..."]

        events_hash.merge!({
          "#{schedule.start_time.strftime('%Y-%m-%d')}" => {
            "number" => where(start_time: schedule.start_time.beginning_of_day..schedule.start_time.end_of_day).count,
            "names" => names
          }
        })
      end
      events_hash
    end

    def day_events(month: nil, year: nil, day: nil, current_school_branch_id: nil)
      start_time = "#{month}/#{day}/#{year}".to_datetime.beginning_of_day
      end_time = start_time.end_of_day

      includes(:creator).where(
        [
          "school_branch_id = ? AND \
          start_time >= ? ANd \
          start_time <= ?",
          current_school_branch_id, start_time, end_time
        ]
      )
    end

  end

  def can_delete?
    start_time.to_date > Time.now.to_date
  end

  private

  def ensure_event_for_is_set
    if event_for["ids"].blank?
      self.errors.add(:event_for, "~Please select one or more class room")
      false
    end
  end

end
