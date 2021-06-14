class ApartmentsController < ApplicationController
  def index
    apartments = Apartment.all
    render json: apartments, status: 200
  end

  def show
    apartment = find_apt
    if apartment
      render json: apartment, status: 200
    else
      render_not_found_response
    end
  end

  def create
    apartment = Apartment.new(apt_params)
    if apartment.valid?
      apartment.save
      render json: apartment, status: 201
    else
      render json: { errors: apartment.errors.full_messages }, status: 422
    end
  end

  def update
    apartment = find_apt
    apartment.update(apt_params)
    render json: apartment
  end

  def destroy
    apartment = find_apt
    if apartment
      apartment.destroy
      render json: {}, status: 204 #can also do :not_found
    else
      render_not_found_response
    end
  end

  private

  def find_apt
    Apartment.find(params[:id])
  end

  def apt_params
    params.permit(:number)
  end

  def render_not_found_response
    render json: { error: "Apartment not found" }, status: 404
  end
end
