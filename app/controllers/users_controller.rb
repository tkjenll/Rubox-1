class UserController < ApplicationController
  def index
    @msg = "Mensaje pasado por el controlador"
    @nose = 52*8
  end
end
