class ApartmentSerializer < ActiveModel::Serializer
  attributes :id, :number, :rent_total

  def rent_total
    self.object.leases.sum(:rent)
  end
end
