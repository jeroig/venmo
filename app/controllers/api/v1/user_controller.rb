# frozen_string_literal: true

module Api
  module V1
    class UserController < ApplicationController
      include Pagy::Backend
      before_action :set_user
      before_action :set_values, only: [:payment]

      def payment
        PaymentService.new(@sender, @receiver, @amount, @description).call
      end

      def feed
        # (WIP) Just for activate the endpoint, list all Payments without
        # any condition in order to setup the pagination
        pagy, payments = pagy(Payment.includes(:sender, :receiver))
        response = { meta: pagy_metadata(pagy), data: [] }
        response[:data] = payments.map { |payment| { title: payment.title } }
        render json: response.to_json
      end

      def balance
        render json: @user.to_json(only: [:balance]), status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def set_values
        @sender      = @user
        @receiver    = User.find(params[:friend_id])
        @amount      = params[:amount].to_f
        @description = params[:description].to_f
      end
    end
  end
end
