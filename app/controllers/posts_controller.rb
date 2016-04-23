class PostsController < ApplicationController
  before_filter do
    if params[:category_id]
      @post_category = PostCategory.where(:permalink => params[:category_id]).first!
    end
    if @post_category && params[:post_id]
      @post = @post_category.posts.where(:permalink => params[:post_id]).active.first!
    end
  end
  
  def index
    # @posts = @post_category.posts.includes(:product_categories, :variants).root.active
    @query = Post.active.ordered.page(params[:page]).search(params[:q])
    @posts = @query.result
  end
  
  def filter
    @posts = Post.active.with_attributes(params[:key].to_s, params[:value].to_s)
  end
  
  def categories
    @post_categories = PostCategory.ordered
  end
  
  def show
    # @attributes = @post.product_attributes.public.to_a
  end
end
