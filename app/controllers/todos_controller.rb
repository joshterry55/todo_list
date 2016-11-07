class TodosController < ApplicationController
  def index
    @todos = Todo.order("priority DESC").all
    @percent = ((Todo.where(complete: true).count.to_f / Todo.count(:all).to_f) * 100).to_i
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to todos_path(@todo)
    else
      render :new
    end
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)

      redirect_to todos_path(@todo)
    else
      render :edit
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to todos_path(@todo)
  end

  private
  def todo_params
    params.require(:todo).permit(:item, :complete, :details, :priority)
  end

end
