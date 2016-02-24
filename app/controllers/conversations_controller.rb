class ConversationController < ApplicationController


  def new
    @conversation = Conversation.new
  end

  def show
    @conversation = Conversation.last
    @messages = @conversation.messages
  end

end
