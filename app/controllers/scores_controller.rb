class ScoresController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.student?
      @scores = current_user.scores
    elsif current_user.parent?
      @scores = Score.where(student_id: current_user.children.pluck(:id))
    end
  end
end
