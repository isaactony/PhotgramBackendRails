class LikesController < ApplicationController
    def index
        @likes = Like.all.order(created_at: :desc)
        render json: @likes
    end
    # def index
    #     post = Post.find(params[:id])
    #     likes = post.likes
    #     render json: likes
    #   end
    
      def count
        post = Post.find(params[:id])
        count = post.likes.count
        render json: { count: count }
      end

end
