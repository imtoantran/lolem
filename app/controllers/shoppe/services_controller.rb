module Shoppe
  class ServicesController < Shoppe::ApplicationController
    before_filter { @active_nav = :services }
    before_filter { params[:id] && @service = Service.find(params[:id]) }
    def index
      @query = Service.ordered.page(params[:page]).search(params[:q])
      @services = @query.result
    end
    def edit
    end
    def new
      @service = Service.new
    end
    def create
      @service = Service.new(safe_params)
      if @service.save
        redirect_to :services, flash: { notice: t('shoppe.services.create_notice') }
      else
        render action: 'new'
      end
    end
    def update
      if @service.update(safe_params)
        redirect_to [:edit, @service], flash: { notice: t('shoppe.posts.update_notice') }
      else
        render action: 'edit'
      end
    end
    def safe_params
      file_params = [:file, :parent_id, :role, :parent_type, :file => []]
      params[:service].permit(:name, :excerpt, :description, :attachments => [:default_image => file_params], post_category_ids: [])
    end
  end
end

