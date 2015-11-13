class StoreController < ApplicationController
  include ViewCounter

  before_action :increment_counter

  def index
    @products = Product.order(:title)
  end
end
