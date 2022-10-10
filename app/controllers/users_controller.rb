class UsersController < ApplicationController
  # create method that responds to a POST /signup request
    def create
        user = User.create(user_params)

        if user

            session[:user_id] = user.id
            render json: user, status: :created
    
        else

            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
        
    # show method that responds to a GET /me request.
      def show
       
        user = User.find_by(id: session[:user_id])
        
        if user
            render json: user
        else
            render json: { error: "Not authorized" }, status: :unauthorized
        end
      end
    
      private
      def user_params
        params.permit(:username, :password, :password_confirmation)
      end
      def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
      end
    
      
     
end
