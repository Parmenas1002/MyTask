class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit,:update,:destroy]
    def index
        if params[:sort_expired]
            @tasks = Task.order_by_deadline.page params[:page]
        elsif params[:task].present?
            if (params[:task][:title]!= "" && params[:task][:status]== "")
                @tasks = Task.search_with_title(params[:task][:title]).page params[:page]
            elsif ((params[:task][:title]== "" && params[:task][:status]!= ""))
                @tasks = Task.order_by_status(params[:task][:status]).page params[:page]
            elsif ((params[:task][:title]!= "" && params[:task][:status]!= ""))
                @tasks = Task.search_with_title(params[:task][:title]).order_by_status(params[:task][:status]).page params[:page]
            else
                @tasks = Task.order_by_created_at.page params[:page]
            end
        elsif params[:sort_priority]
            @tasks = Task.order_by_priority_link.page params[:page];
        else
            @tasks = Task.order_by_created_at.page params[:page]
        end       
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        if @task.save
            redirect_to task_path(@task.id), notice: "New Task created with success"
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
          redirect_to task_path(@task.id), notice: "Task update with success"
        else
          render :edit
        end
    end

    def show
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice: "Task delete with success "
    end
    
    private 
    def task_params
        params.require(:task).permit(:title,:description, :expiredDate, :status, :priority)
    end
    def set_task
        @task = Task.find(params[:id])
    end
end
