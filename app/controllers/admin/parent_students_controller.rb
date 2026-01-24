class Admin::ParentStudentsController < Admin::BaseController
  def new
    @parents = User.parent
    @students = User.student
  end

  def create
    ParentStudent.create!(
      parent_id: params[:parent_id],
      student_id: params[:student_id]
    )
    redirect_to admin_students_path, notice: "紐付けが完了しました"
  end

  def destroy
    ParentStudent.find(params[:id]).destroy
    redirect_to admin_students_path, notice: "紐付けを解除しました"
  end
end
