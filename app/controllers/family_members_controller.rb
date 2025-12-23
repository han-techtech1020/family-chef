class FamilyMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family_member, only: [:edit, :update, :destroy]
  
  def index
    @family_members = current_user.family_members
  end

  def new
    @family_member = FamilyMember.new
  end

  def create
    @family_member = current_user.family_members.new(family_member_params)
    if @family_member.save
      redirect_to family_members_path, notice: "家族情報を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @family_member は before_action でセットされています
  end

  def update
    if @family_member.update(family_member_params)
      redirect_to family_members_path, notice: "家族情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @family_member.destroy
    redirect_to family_members_path, notice: "削除しました"
  end

  private

  def set_family_member
    # 他人の家族情報を操作できないように current_user から探す
    @family_member = current_user.family_members.find(params[:id])
  end

  def family_member_params
    params.require(:family_member).permit(:name, :status, :allergy_info)
  end
end
