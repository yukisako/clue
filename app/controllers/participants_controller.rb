class ParticipantsController < ApplicationController
  def create
    Participant.where(user_id: current_user.id, event_id: params[:participant][:event_id]).first_or_create(submit_params)
    redirect_to :back
  end

  def update
    Participant.find_by(user_id: current_user.id, event_id: params[:participant][:event_id]).update(status: params[:commit])
    redirect_to :back
  end

  def destroy
  end

  private
  def submit_params
    params.require(:participant).permit(:event_id, :user_id).merge(status: params[:commit])
  end
end
