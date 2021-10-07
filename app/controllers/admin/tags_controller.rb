class Admin::TagsController < ApplicationController
    before_action :set_tag, only: [:edit,:update, :destroy]
    before_action :check_admin
    def index
        @tags = Tag.all
    end
    def new
        @tag = Tag.new
    end
    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            redirect_to admin_tags_path, notice: "New Tag create with success"
        else  
            render :new
        end
    end
    def edit
    end
    def update
        if @tag.update(tag_params)
            redirect_to admin_tags_path, notice: "Tag update with success"
        else
            render :edit
        end
    end
    def destroy
        @tag.destroy
        redirect_to admin_tags_path, notice: "Tag delete with success"
    end
    private
    def tag_params
        params.require(:tag).permit(:name)
    end
    def set_tag
        @tag = Tag.find(params[:id])
    end
    def check_admin
        unless current_user.admin
            redirect_to tasks_path, notice: "Your are not authorized to see this page"
        end
    end
end
