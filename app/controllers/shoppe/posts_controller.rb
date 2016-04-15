module Shoppe
  class PostsController < Shoppe::ApplicationController
    before_filter { @active_nav = :posts }
    before_filter { params[:id] && @post = Post.find(params[:id]) }
    def index
      @query = Post.ordered.page(params[:page]).search(params[:q])
      @posts = @query.result
    end
    def edit
    end
    def update
      if @post.update(safe_params)
        redirect_to [:edit, @post], flash: { notice: t('shoppe.posts.update_notice') }
      else
        render action: 'edit'
      end
    end
    def safe_params
      file_params = [:file, :parent_id, :role, :parent_type, :file => []]
      params[:post].permit(:title, :full_content, :attachments => [:default_image => file_params], post_category_ids: [])
    end
  end
end

