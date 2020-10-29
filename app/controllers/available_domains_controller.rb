class AvailableDomainsController < ApplicationController
  def index
    render json: AvailableDomainDatatable.new(params)
  end
end
