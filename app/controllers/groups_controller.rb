# frozen_string_literal: true

class GroupsController < ApplicationController
  load_and_authorize_resource
  def index
    @groups = if params[:search].present?
                Group.where('name LIKE ?', "%#{params[:search]}%")
              else
                Group.all
              end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to @group, notice: t('group_created')
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to @group, notice: t('group_updated')
    else
      render :edit
    end
  end

  # def add_member
  #   new_member = User.find_by(id: params[:group][:new_member_id])
  #   if new_member && !@group.group_members.exists?(member_id: new_member.id)
  #     @group.group_members.create(member: new_member)
  #     redirect_to groups_path, notice: "Member added successfully."
  #   else
  #     redirect_to groups_path, alert: "Invalid member or already in group."
  #   end
  # end

  # def remove_member
  #   group_member = @group.group_members.find_by(member_id: params[:remove_member_id])
  #   if group_member
  #     group_member.destroy
  #     redirect_to groups_path, notice: "Member removed successfully."
  #   else
  #     redirect_to groups_path, alert: "Member not found."
  #   end
  # end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path, notice: t('group_deleted')
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
