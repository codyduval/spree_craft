class HomeController < Spree::BaseController
  helper :products
  respond_to :html
  
  def index
    @searcher = Spree::Config.searcher_class.new(params)
    @products = @searcher.retrieve_products
  end
end
