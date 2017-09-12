require 'exponent-server-sdk'

PushJob = Struct.new(:token, :message) do
  def perform
    exponent = Exponent::Push::Client.new

    exponent.publish(
      exponentPushToken: token,
      message: message,
      data: {a:'b'}, # Any arbitrary data to include with the notification
    )
  end

  def max_attempts
    3
  end
end
