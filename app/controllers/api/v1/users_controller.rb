# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user

      def balance
        render json: @user.to_json(only: [:balance]), status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
