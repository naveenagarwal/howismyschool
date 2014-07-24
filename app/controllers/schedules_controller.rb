class SchedulesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @events = Schedule.events(
        month: Time.now.year,
        year: Time.now.month,
        current_school_branch_id: current_school_branch.id
      ).to_json.to_s.html_safe
  end

  def list
    events = Schedule.events(
        month: params[:month],
        year: params[:year],
        current_school_branch_id: current_school_branch.id
      )

    render json: { events: events }
  end

  def day_events
    @events = Schedule.day_events(
        month: params[:month],
        year: params[:year],
        day: params[:day],
        current_school_branch_id: current_school_branch.id
      )
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
    @class_rooms = current_school_branch.class_rooms.all.collect { |p| [ p.full_name, p.id ] }
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.event_for["ids"] = params[:schedule][:event_for][:ids].reject(&:blank?).join(",")
    @schedule.event_for["names"] = ClassRoom.where(id: params[:schedule][:event_for][:ids].reject(&:blank?)).map(&:full_name)
    @schedule.creator = current_teacher
    @schedule.school_branch_id = current_school_branch.id

    respond_to do |format|
      if @schedule.save
        MailerWorker.perform_async :schedule_added, [@schedule.id]
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.js { set_flash_messages type: "notice", message: "Schedule saved sucessfully" }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.js { }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    respond_to do |format|
      if @schedule.destroy
        MailerWorker.perform_async :schedule_destroyed, [ @schedule.title, @schedule.start_time,
            @schedule.end_time, @schedule.notification_emails_list
          ]

        format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
        format.js { }
        format.json { head :no_content }
      else
        format.html { redirect_to schedules_url, notice: 'Schedule could not be destroyed.' }
        format.js { }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_schedule
    @schedule = current_school_branch.schedules.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:title, :start_time, :end_time,
        event_for: [ :type, ids: [] ]
      )
  end
end
