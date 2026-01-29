class Admin::ParentStudentsController < Admin::BaseController
  def new
    @parent = User.parent.find(params[:parent_id])
    @students = User.student
  end

  def create
    ParentStudent.create!(
      parent_id: params[:parent_id],
      student_id: params[:student_id]
    )

    redirect_to admin_parents_path, notice: "生徒を紐付けました"
  end

  def destroy
    ParentStudent.find(params[:id]).destroy
    redirect_to admin_parents_path, notice: "紐付けを解除しました"
  end
end
