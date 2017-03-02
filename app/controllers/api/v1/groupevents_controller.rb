class Api::V1::GroupeventsController < ApplicationController
  before_action :find_group_event, only: [:show, :publish, :destroy, :update]

  def index
    render json: { group_events: Groupevent.all }
  end

  def create
    group_event = Groupevent.new(group_event_params)
    if group_event.save
      render json: { id: group_event.id }
    else
      render json: { errors: group_event.errors }
    end
  end

  def show
    render json: { status: 'OK' , group_event: @group_event }
  end

  def update

    if @group_event.update(event_params)
      render_ok
    else 
      render json: { errors: @group_event.errors }
    end
  end

  def destroy
    @group_event.destroy
    render_ok
  end

  def publish
    if @group_event.publish!
       render_ok
    else
       render json: { error: t('groupevents.errors.empty_fields') }
    end
  end

  private

  def render_ok
    render json: { status: t('groupevents.ok') }
  end

  def find_group_event
    @group_event = Groupevent.find(params[:id])
  end

  def group_event_params
    params.permit(:name, :description, :location, :start_date, :end_date, :duration)
  end
end
