class AppointmentsController < ApplicationController
  def index
    @appointments = current_user.appointments
  end



# app/controllers/appointments_controller.rb
def create
  @appointment = Appointment.new(appointment_params)
  @appointment.user = current_user
  @appointment.daddy_service = DaddyService.find(params[:daddy_service_id])

  if @appointment.save
    redirect_to appointments_path, notice: 'Rendez-vous créé avec succès!'
  else
    flash[:alert] = @appointment.errors.full_messages.join(", ")
    redirect_to daddy_service_path(@appointment.daddy_service)
  end
end

private

def appointment_params
  params.require(:appointment).permit(:date, :time)
end
end
