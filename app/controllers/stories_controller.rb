# frozen_string_literal: true

# Story controller to handle creating of story
class StoriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @story = @post.stories.new(place_name: @post.place_name, address: @post.address)
  end

  def create
    @post = Post.find(params[:post_id])
    @story = @post.stories.build(story_params)
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
