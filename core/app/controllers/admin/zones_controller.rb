class Admin::ZonesController < Admin::ResourceController
  before_filter :load_data, :except => [:index]

  def new
    @zone.zone_members.build
  end

  protected

  def collection
    params[:search] ||= {}
    params[:search][:meta_sort] ||= "ascend_by_name"
    @search = super.search(params[:search])
    @zones = @search.result(:distinct => true).page(params[:page]).per(Spree::Config[:orders_per_page])
  end

  def load_data
    @countries = Country.order(:name)
    @states = State.order(:name)
    @zones = Zone.order(:name)
  end
end
