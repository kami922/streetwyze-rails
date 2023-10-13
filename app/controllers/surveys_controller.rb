# frozen_string_literal: true

# Surveys Controller for handling survey and questions
class SurveysController < ApplicationController
  def new
    @survey = Survey.new
    @questions = @survey.questions.build
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to survey_path(@survey), notice: 'created successfully'
    else
      render :new, alert: 'something went wrong try again'
    end
  end

  def new_release
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:title, :script, question_attributes: [:id, :statement, :open, { question_ids: [] }])
  end
end
