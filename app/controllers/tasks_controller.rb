class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit,:update,:destroy]
    def index
        if params[:sort_expired]
            @tasks = Task.all.order(expiredDate: :desc)
        elsif params[:task]
            if (params[:task][:title]!= "" && params[:task][:status]== "")
                @tasks = Task.where("title LIKE ?", "%#{params[:task][:title]}%")
            elsif ((params[:task][:title]== "" && params[:task][:status]!= ""))
                @tasks = Task.where(status: params[:task][:status])
            elsif ((params[:task][:title]!= "" && params[:task][:status]!= ""))
                @tasks = Task.where("title LIKE ? AND status= ?", "%#{params[:task][:title]}%", params[:task][:status].to_i)
            else
                @tasks = Task.all.order(created_at: :desc)
            end
        else
            @tasks = Task.all.order(created_at: :desc)
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
        params.require(:task).permit(:title,:description, :expiredDate, :status)
    end
    def set_task
        @task = Task.find(params[:id])
    end
end
