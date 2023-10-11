# frozen_string_literal: true

# Story controller to handle creation of story
class StoriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @story = @post.stories.new(place_name: @post.place_name, address: @post.address)
  end

  def export
    @stories = Story.all
    respond_to do |format|
      format.csv { send_data @stories.to_csv, filename: "all_stories-#{Date.today}.csv" }
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @story = @post.stories.build(story_params)
    @story.place_name = @post.place_name
    @story.address = @post.address
    @story.user = current_user
    if @story.save
      redirect_to root_path, notice: 'Story shared successfully.'
    else
      render :new, alert: 'Failed to share the story.'
    end
  end

  private

  def story_params
    params.require(:story).permit(:description, :rating, :place_name, :address, :stuff, :category)
  end
end
