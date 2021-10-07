class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit,:update,:destroy]
    def index
        if params[:sort_expired]
            @tasks = current_user.tasks.order_by_deadline.page params[:page]
        elsif params[:task].present?
            if (params[:task][:title]!= "" && params[:task][:status]== "")
                @tasks = current_user.tasks.search_with_title(params[:task][:title]).page params[:page]
            elsif ((params[:task][:title]== "" && params[:task][:status]!= ""))
                @tasks = current_user.tasks.order_by_status(params[:task][:status]).page params[:page]
            elsif ((params[:task][:title]!= "" && params[:task][:status]!= ""))
                @tasks = current_user.tasks.search_with_title(params[:task][:title]).order_by_status(params[:task][:status]).page params[:page]
            elsif ((params[:task][:title]== "" && params[:task][:status]== "" && params[:task][:tag_id]!= ""))
                tag = Tag.find(params[:task][:tag_id].to_i)
                @tasks = tag.tasks.where(user_id: current_user.id).page params[:page]
            else
                @tasks = current_user.tasks.order_by_created_at.page params[:page]
            end
        elsif params[:sort_priority]
            @tasks = current_user.tasks.order_by_priority_link.page params[:page];
        else
            @tasks = current_user.tasks.order_by_created_at.page params[:page]
        end       
    end

    def new
        @task = Task.new
    end

    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            redirect_to task_path(@task.id), notice: "You add new Task with success"
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @task.update(task_params)
          redirect_to task_path(@task.id), notice: "You update Task with success"
        else
          render :edit
        end
    end

    def show
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice: "You delete Task with success "
    end
    
    private 
    def task_params
        params.require(:task).permit(:title,:description, :expiredDate, :status, :priority, tag_ids: [])
    end
    def set_task
        @task = Task.find(params[:id])
    end
end
