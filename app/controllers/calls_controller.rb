class CallsController < ApplicationController
  def new
    @no_log_out = true
    @in_call = true
    @start_time = Time.now
    session[:call_start_time] = @start_time


    @call = Call.new
    @call.ticket = default_ticket
    @call.start_time = @start_time
    @call.user_id = current_user.id
    authorize @call
    @call.save

    @new_ticket = Ticket.new
    @edit_ticket = nil
    session[:current_call_id] = @call.id

  end

  # def create
  #   call_id = ticket_params.delete(:call_id)
  #   @call=Call.find(call_id)
  #   @call.update end_time: Time.now
  #   @call.update duration: @call.end_time - @call.start_time

  #   cleaned_params = ticket_params.reject {|k,v| k == 'call_id'}

  #   @ticket = Ticket.new(cleaned_params)
  #   @ticket.calls << @call

  #   @ticket.author = current_user
  #   @ticket.status = 'new'
  #   authorize @ticket

  #   redirect_to root_path, notice: 'Call was logged with no ticket.'
  #   end

  # end

  def edit
    # call_id = ticket_params.delete(:call_id)
    # @call=Call.find(call_id)
    # session[:call_end_time] = Time.now
    # @calll.end_time = @end_time
    # @session_end_time = @session[:call_end_time]
    # @call.update end_time: Time.now.to_datetime
    # @call.update duration: Time.at(@call.end_time - @call.start_time).utc.strftime("%H:%M:%S")
    # leaned_params = ticket_params.reject {|k,v| k == 'call_id'}
  end

  private

  def default_ticket
      Ticket.create(customer_cnic: "N/A", author: current_user, category:'N/A', department:"N/A", status:"N/A" )
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_ticket
    @ticket = Ticket.find(params[:id])
    authorize @ticket
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def ticket_params
    params.require(:ticket).permit(:category, :department, :next_step, :description, :status, :author, :customer, :assignee, :assigner, :call_id)
  end
end
