# frozen_string_literal: true

class SettlementsController < ApplicationController
  load_and_authorize_resource
  def index
    @settlements = if params[:search].present?
                     Settlement.where('amount LIKE ?', "%#{params[:search]}%")
                   else
                     Settlement.all
                   end
  end

  def new
    @settlement = Settlement.new
  end

  def create
    @settlement = Settlement.new(settlement_params)
    if @settlement.save
      redirect_to @settlement, notice: t('settlement_created')
    else
      render :new
    end
  end

  def show
    @settlement = Settlement.find(params[:id])
  end

  def edit
    @settlement = Settlement.find(params[:id])
  end

  def update
    @settlement = Settlement.find(params[:id])
    if @settlement.update(settlement_params)
      redirect_to @settlement, notice: t('settlement_updated')
    else
      render :edit
    end
  end

  def destroy
    @settlement = Settlement.find(params[:id])
    @settlement.destroy
    redirect_to settlements_path, notice: t('settlement_deleted')
  end

  private

  def settlement_params
    params.require(:settlement).permit(:payer_id, :payee_id, :amount)
  end
end
