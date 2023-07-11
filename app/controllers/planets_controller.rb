class PlanetsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Planet.all
    end

    def show
        render json: find_planet
    end

    def update
        planet = find_planet
        planet.update!(planet_params)
        render json: planet, status: :accepted
    end

    def destroy
        planet = find_planet
        planet.destroy
        render json: {}
    end

    private

    def record_not_found
        render json: { error: 'Planet not found' }, status: :not_found
    end

    def record_invalid e 
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def find_planet
        Planet.find(params[:id])
    end

    def planet_params
        params.permit(:name, :distance_from_earth, :nearest_star, :image)
    end
end
