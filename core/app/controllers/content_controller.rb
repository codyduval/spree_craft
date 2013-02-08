class ContentController < Spree::BaseController
  # Don't serve local files or static assets
  before_filter { render_404 if params[:path] =~ /(\.|\\)/ }

  rescue_from ActionView::MissingTemplate, :with => :render_404
  caches_page :show, :index, :if => Proc.new { Spree::Config[:cache_static_content] }

  respond_to :html

  def show
    respond_to do |format|
      format.html { render :action => params[:path] }
    end
  end

  def cvv
    respond_to do |format|
      format.html {  render "cvv", :layout => false }
    end
  end
end
