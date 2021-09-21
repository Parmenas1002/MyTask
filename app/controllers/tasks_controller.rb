class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit,:update,:destroy]
    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        if @task.save
            redirect_to tasks_path, notice: "New Task created with success"
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
          redirect_to tasks_path, notice: "Task update with success"
        else
          render :edit
        end
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice: "Task delete with success "
      end
    
    private 
    def task_params
        params.require(:task).permit(:title,:description)
    end
    def set_task
        @task = Task.find(params[:id])
    end
end
