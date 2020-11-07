class BitsController < ApplicationController
    def index
    end

    def new
        @bit = Bit.new
    end

    def create
        @bit = Bit.create(bit_params)
        redirect_to root_path
    end

    private

    def bit_params
        params.require(:bit).permit(:message)
    end
end
