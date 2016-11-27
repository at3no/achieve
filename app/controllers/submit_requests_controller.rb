class SubmitRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_submit_request, only: [:show, :edit, :update, :destroy, :approve, :reject]

  def index
    @submit_requests = SubmitRequest.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @submit_request = current_user.submit_requests.build
  end

  def edit
  end

  def create
    @submit_request = current_user.submit_requests.build(submit_request_params)
    respond_to do |format|
      if @submit_request.save
        format.html { redirect_to @submit_request, notice: 'Submit request was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @submit_request.update(submit_request_params)
        format.html { redirect_to @submit_request, notice: 'Submit request was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @submit_request.destroy
    respond_to do |format|
      format.html { redirect_to submit_requests_url, notice: 'Submit request was successfully destroyed.' }
    end
  end

  def inbox
    @submit_requests = SubmitRequest.where(request_user_id: current_user.id).where(status: 1)
  end

  def approve
    if @submit_request.update(submit_request_params)
      @submit_request.task.update(charge_id: current_user.id)
      redirect_to inbox_submit_requests_path, notice: '依頼を承認しました。'
    else
      redirect_to inbox_submit_requests_path, notice: '不具合が発生しました、もう一度操作を行ってください。'
    end
  end

  def reject
    if @submit_request.update(submit_request_params)
      redirect_to inbox_submit_requests_path, notice: '依頼を却下しました。'
    else
      redirect_to inbox_submit_requests_path, notice: '不具合が発生しました、もう一度操作を行ってください。'
    end
  end

  private
    def set_submit_request
      @submit_request = SubmitRequest.find(params[:id])
    end

    def submit_request_params
      params.require(:submit_request).permit(:user_id, :task_id, :message, :request_user_id, :status)
    end
end
