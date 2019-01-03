class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only:[:show,:edit,:update,:destroy]
  before_action :same_user_require, only:[:show,:edit,:update,:destroy]

  # GET /messages
  # GET /messages.json
  def index
    @message = Message.new
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new  
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      # redirect_to messages_path
      ActionCable.server.broadcast "chatroom_channel", msg_body: message_render(@message)
    else
      flash[:error] = @message.errors.full_messages
      redirect_to messages_path
    end
    # respond_to do |format|
      # if @message.save
        # format.html { redirect_to @message, notice: 'Message was successfully created.' }
        # format.json { render :show, status: :created, location: @message }
      # else
        # format.html { render :new }
        # format.json { render json: @message.errors, status: :unprocessable_entity }
      # end
    # end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end
    
    def same_user_require
      if current_user != @message.user
        flash[:error] = "You can Edit/Update your own messages !!"
        redirect_to messages_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:msg, :user_id)
    end
    
    def message_render(message)
      render(partial: 'message', locals:{message: message})
    end
end
