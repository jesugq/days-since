class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @total_count = Event.count
    @page = [(params[:page] || 1).to_i, 1].max
    @per_page = [(params[:per_page] || 25).to_i.clamp(1, 100), 1].max
    @events = Event.order(occurred_on: :desc)
                   .offset((@page - 1) * @per_page)
                   .limit(@per_page)

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event }
        format.json { render :create, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @event.errors }, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event }
        format.json { render :show }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @event.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_path }
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = Event.find_by!(slug: params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :occurred_on, :slug)
  end
end
