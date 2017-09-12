class TokensController < ApplicationController
  def create
    # You probably actually want to associate this with a user,
    # otherwise it's not particularly useful
    @token = Token.where(value: params[:token][:value]).first


    if @token.blank?
      @token = Token.create(token_params)
    end

    raise "Message is empty!" if params[:message].blank?

    Delayed::Job.enqueue PushJob.new(@token.value, params)

    render json: {success: true}
  end

  private
  def token_params
    params.require(:token).permit(:value)
  end

  def exponent
    @exponent ||= Exponent::Push::Client.new
  end

end
