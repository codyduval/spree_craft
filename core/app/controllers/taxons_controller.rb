class TaxonsController < Spree::BaseController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  helper :products

  respond_to :html

  def show
    @taxon = Taxon.find(params[:id])
    return unless @taxon

    @searcher = Spree::Config.searcher_class.new(params.merge(:taxon => @taxon.id))
    @products = @searcher.retrieve_products
  end

  private

  def accurate_title
    @taxon ? @taxon.name : super
  end
end
