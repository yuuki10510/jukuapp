class Admin::ParentsController < Admin::BaseController
  def index
    @parents = User.where(role: :parent)
  end
end
