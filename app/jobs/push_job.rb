require 'exponent-server-sdk'

PushJob = Struct.new(:token, :body) do
  def perform
    exponent = Exponent::Push::Client.new

    exponent.publish(
      exponentPushToken: token,
      message: body[:message],
      data: body[:data] || { n: nil } , # Any arbitrary data to include with the notification
    )
  end

  def max_attempts
    3
  end
end
