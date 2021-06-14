class LeasesController < ApplicationController
  def create
    lease = Lease.new(params_lease)
    if lease.valid?
      lease.save
      render json: lease, status: 201
    else
      render json: { errors: lease.errors.full_messages }, status: 422
    end
  end

  def destroy
    lease = Lease.find(params[:id])
    if lease
      lease.destroy
      render json: {}, status: 204
    else
      render_not_found_response
    end
  end

  private

  def params_lease
    params.permit(:rent, :apartment_id, :tenant_id)
  end

  def render_not_found_response
    render json: { error: "Apartment not found" }, status: 404
  end
end
