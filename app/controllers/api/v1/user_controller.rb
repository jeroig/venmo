# frozen_string_literal: true

module Api
  module V1
    class UserController < ApplicationController
      include Pagy::Backend
      before_action :set_user

      def payment
        PaymentService.new(@user, payload_params).call
        head :no_content
      end

      def feed
        pagy, payments = pagy(Payment.activity_feed(@user).by_newest)
        response = { meta: pagy_metadata(pagy), data: [] }
        response[:data] = payments.map { |payment| { id: payment.id, title: payment.title } }
        render json: response.to_json
      end

      def balance
        render json: @user.to_json(only: [:balance]), status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def payload_params
        params.require(:payload).permit(:friend_id, :amount, :description)
      end
    end
  end
end
