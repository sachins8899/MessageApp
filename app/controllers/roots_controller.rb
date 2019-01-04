class RootsController < ApplicationController
  def new
    if loged_in? 
      redirect_to messages_path
    end
  end
end