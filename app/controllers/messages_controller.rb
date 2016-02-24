class MessagesController < ApplicationController


  def new
    @conversation = Conversation.find(1)
    @message = @conversation.messages.new
  end

  def show
    @conversation = Conversation.last
    @messages = @conversation.messages
  end

  def create
    @conversation = Conversation.find(1)
    @message = @conversation.messages.new(message_params)
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(:msg, :conversation_id )
  end

end