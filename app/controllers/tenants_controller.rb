class TenantsController < ApplicationController
  def index
    tenants = Tenant.all
    render json: tenants, status: 200
  end

  def show
    tenant = find_tenant
    if tenant
      render json: tenant, status: 200
    else
      render_not_found_response
    end
  end

  def create
    tenant = Tenant.new(params_tenant)
    if tenant.valid?
      tenant.save
      render json: tenant, status: 201
    else
      render json: { errors: tenant.errors.full_messages }, status: 422
    end
  end

  def destroy
    tenant = find_tenant
    if tenant
      tenant.destroy
      render json: {}, status: 204
    else
      render_not_found_response
    end
  end

  private

  def find_tenant
    Tenent.find(params[:id])
  end

  def params_tenant
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: "Tenant not found" }, status: 404
  end
end
