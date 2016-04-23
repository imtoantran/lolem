class ServicesController < ApplicationController
  before_filter do
    if params[:service_id]
      @service = Service.where(:permalink => params[:service_id]).active.first!
    end
  end
  def show

  end
  def index
    @query = Service.active.ordered.page(params[:page]).search(params[:q])
    @services = @query.result
  end
end
