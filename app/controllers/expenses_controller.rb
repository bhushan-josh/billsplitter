# frozen_string_literal: true

class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index
    @expenses = if params[:search].present?
                  Expense.where('title LIKE ?', "%#{params[:search]}%")
                else
                  Expense.all
                end
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to @expense, notice: 'Expense created successfully.'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @expense.update(expense_params)
      redirect_to @expense, notice: 'Expense updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path, notice: 'Expense deleted successfully.'
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:title, :amount, :description)
  end
end
