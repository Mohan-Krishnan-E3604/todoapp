class UsersController < ApplicationController

  skip_before_action :authorize_request, only: :create

  # POST /signup
  def create
    user = User.create!(user_params)
    UserWelcomeWorker.perform_async({email: user.email, name: user.name}.with_indifferent_access)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = {message: Message.account_created, auth_token: auth_token}
    json_response(response, :created)
  end


  def auto_complete
    results = User.search(params[:query], {
        fields: ['name'],
        select: ['name', 'email'],
        match: :word_start,
        limit: 10,
        load: false
    })
    results = results.map do |r|
      {id: r[:id], name: r[:name], email: r[:email]}
    end
    json_response(results, :ok)
  end

  private

  def user_params
    params.permit(
        :name,
        :email,
        :password,
        :password_confirmation
    )
  end
end