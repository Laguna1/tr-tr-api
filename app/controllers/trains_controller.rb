class TrainsController < ApplicationController
    before_action :set_train, only: [:show, :update, :destroy]

    # GET /trains
    def index
      @trains = Train.all
      json_response(@trains)
    end
  
    # POST /trains
    def create
      @train = Train.create!(train_params)
      json_response(@train, :created)
    end
  
    # GET /trains/:id
    def show
      json_response(@train)
    end
  
    # PUT /trains/:id
    def update
      @train.update(train_params)
      head :no_content
    end
  
    # DELETE /trains/:id
    def destroy
      @train.destroy
      head :no_content
    end
  
    private
  
    def train_params
      # whitelist params
      params.permit(:name, :description)
    end
  
    def set_train
      @train = Train.find(params[:id])
    end
end
