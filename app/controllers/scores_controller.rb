class ScoresController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.student?
      # 生徒本人
      @students = [current_user]

    elsif current_user.parent?
      # 保護者 → 紐付いた生徒一覧
      @students = current_user.children

    else
      # 管理者はこの画面には来ない想定
      redirect_to root_path, alert: "アクセス権限がありません"
    end
  end
end
