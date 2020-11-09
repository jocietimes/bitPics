class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
        @bit = Bit.find_by_id(params[:bit_id])
        return render_not_found if @gram.blank?

        @bit.comments.create(comment_params.merge(user: current_user))
        if @comment.valid?
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:message)
    end
end
