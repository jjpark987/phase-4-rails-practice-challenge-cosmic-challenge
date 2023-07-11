class ScientistsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Scientist.all
    end

    def show
        render json: find_scientist, serializer: ScientistPlanetsSerializer
    end

    def create
        render json: Scientist.create!(scientist_params), status: :created
    end

    def update
        scientist = find_scientist
        scientist.update!(scientist_params)
        render json: scientist, status: :accepted
    end

    def destroy
        scientist = find_scientist
        scientist.destroy
        render json: {}
    end

    private

    def record_not_found
        render json: { error: 'Scientist not found' }, status: :not_found
    end

    def record_invalid e 
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def find_scientist
        Scientist.find(params[:id])
    end

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end
end
