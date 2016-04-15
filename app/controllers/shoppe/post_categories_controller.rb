module Shoppe
  class PostCategoriesController < Shoppe::ApplicationController
    @post_categories
    before_filter { @active_nav = :post_categories }
    before_filter { params[:id] && @post_category = PostCategory.find(params[:id]) }
    def index
      @query = PostCategory.ordered.page(params[:page]).search(params[:q])
      @post_categories = @query.result
    end
    def update
      if @post_category.update(safe_params)
        redirect_to [:edit, @post_category], flash: { notice: t('shoppe.posts.update_notice') }
      else
        render action: 'edit'
      end
    end
    def safe_params
      file_params = [:file, :parent_id, :role, :parent_type, :file => []]
      params[:post_category].permit(:name, :description,:permalink, :attachments => [:default_image => file_params])
    end
  end
end

