class TracksController < ApplicationController
  before_action :set_train
  before_action :set_train_track, only: %i[show update destroy]

  # GET /trains/:train_id/tracks
  def index
    json_response(@train.tracks)
  end

  # GET /trains/:train_id/tracks/:id
  def show
    json_response(@track)
  end

  # POST /trains/:train_id/tracks
  def create
    @train.tracks.create!(track_params)
    json_response(@train, :created)
  end

  # PUT /trains/:train_id/tracks/:id
  def update
    @track.update(track_params)
    head :no_content
  end

  # DELETE /trains/:train_id/tracks/:id
  def destroy
    @track.destroy
    head :no_content
  end

  private

  def track_params
    params.permit(:name, :done)
  end

  def set_train
    @train = Train.find(params[:train_id])
  end

  def set_train_track
    @track = @train.tracks.find_by!(id: params[:id]) if @train
  end
end
