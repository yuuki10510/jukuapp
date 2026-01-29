class Admin::ParentsController < Admin::BaseController
  def index
    @parents = User.where(role: :parent)
    @parents = User.parent.includes(:children)
  end
end
