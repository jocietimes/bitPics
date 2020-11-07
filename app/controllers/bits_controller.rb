class BitsController < ApplicationController

    def index
    end

    def new
        @bit = Bit.new
    end

    def create
        @bit = Bit.create(bit_params)
        if @bit.valid?
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def bit_params
        params.require(:bit).permit(:message)
    end
end
