##
## Kpass OAuth Controller Example
##
## Although this code in example is written for Ruby on Rails using the Devise
## authentication Ruby Gem, the flow of logic should be relatable to any web MVC
## framework you may be using.
##
## The following code depends on a couple of environment variables being
## configured. This will vary from application instance to application instance
## (for example, between a testing and production environment.) The values
## for these environment variables will be provided for you separately when
## getting started with Kpass.
##

class KpassController < ApplicationController

  # we disable forgery protection for webhooks so clients don't have to fetch a
  # token. this is rails-specific.
  protect_from_forgery except: :webhooks

  # this action is run when a user hits the '/kpass/authorize' route. we link
  # to this with all our "sign in with kpass" buttons in the sample app.

  # when a user hits "/kpass/authorize"
  # we link to this from our 'sign in with kpass' buttons in the sample app.
  def authorize

    # redirect to kpass for authorization (and authentication if they're not
    # signed in.)
    redirect_to "#{ENV['KPASS_ENDPOINT']}/oauth/authorize?app_id=#{ENV['KPASS_APP_ID']}"

  end

  # when a user hits '/kpass/profile'
  # we link to this from our 'your account' links in the sample app.
  def profile

    # redirect to kpass where they can edit their profile and provide a url
    # where they should return in our app. for example, we can provide the url
    # of the page the link was presented on, so they return there when they're
    # done editing their profile.
    # redirect_to "#{ENV['KPASS_ENDPOINT']}?app_id=#{ENV['KPASS_APP_ID']}&return_to=#{URI::escape(params['return_to'])}"

    redirect_to "#{ENV['KPASS_ENDPOINT']}?app_id=#{ENV['KPASS_APP_ID']}&return_to=#{URI::escape(params['return_to'])}"
  end

  # when a user hits '/kpass/verify'
  # this is where kpass redirects the user back to once they've authorized the
  # application, regardless of whether under-13 users have obtained permission
  # to actually share information with the sample app yet.
  def verify

    # if we haven't already authenticated a user in the sample app.
    # (this is a helper method of devise, the rails ruby gem we're using for
    # authentication in the sample app.)
    unless current_user.present?

      # we need to fetch the contents of a url, so include required libraries.
      require 'open-uri'

      # swap out our single-use token which was provided by kpass, for a secret
      # access key and some other user details for this user. this is standard
      # oauth stuff.
      verify_url = "#{ENV['KPASS_ENDPOINT']}/oauth/verify?api_key=#{ENV['KPASS_API_KEY']}&token=#{params[:token]}"
      json = open(verify_url).read
      response = JSON.parse(json)

      puts ""
      puts " %%%%%%%%%%%"
      puts ""
      puts response.inspect

      # find or create a new user based on the username of the kpass account.
      # for over-13 users, the json will include their username (since they're
      # allowed to authorize the sharing of it.) if it's not present (because
      # they're under 13,) we generate a temporary random username that will be
      # replaced when the parent authorizes kpass to share the user's username
      # with the sample app. it will arrive via a webhook and is handled in
      # another method below. random_username is also defined below.
      kpass_id = response["member"]["id"]
      username = response["member"]["username"] || random_username

      # only create a new user record for them if we don't already have a user
      # record for their unique id.
      @user = User.find_or_create_by(kpass_id: kpass_id)

      # set or update the username.
      @user.username = username

      # store the api key we have for this user.
      @user.kpass_access_key = response["access_key"]

      # save the user in the sample app.
      @user.save


      puts @user.inspect

      # mark the user as signed in locally.
      # (this is a helper method of devise, the rails ruby gem we're using for
      # authentication in the sample app.)
     # session_sign_in(@user)

    end

    # if the user was bumped into the authorization workflow because they tried
    # to do something in the app that required authentication..
    # (this is a feature of devise, the rails ruby gem we're using for
    # authentication in the sample app.)
    if session['after_sign_in'].present?

      # redirect them back to whatever it was they were doing.
      after_sign_in = session['after_sign_in']
      session['after_sign_in'] = nil
      # redirect_to after_sign_in

    # if the user was just generally signing in..
    else

      # show them the list of rooms they can now chat in.
      # redirect_to rooms_path

      puts @user.inspect

    end

  end

  # when a user hits '/kpass/profile'
  def sign_out

    # mark them as signed out.
    # (this is a helper method of devise, the rails ruby gem we're using for
    # authentication in the sample app.)
    #session_sign_out    <----   NEED TO CHANGE TO CUSTOM USER SIGN OUT

    # send them back to the homepage.
    redirect_to root_path

  end

  # when kpass sends a request to '/kpass/webhooks'
  # (this is a server-to-server request)
  def webhooks

    # parse the json data.
    data = JSON.parse(params['json'])

    # if it's an authorization webhook.
    if data['type'].include?("member.authorization")

      # fetch the user for this webhook.
      user = User.find_by(kpass_id: data['data']['object']['member']['id'])

      # if we found the user in our sample app..
      if user.present?

        # if the webhook is telling us they've been approved..
        if data['type'] == "member.authorization.approved"

          # update the username of the user, since we should have access to it now.
          user.handle = data['data']['object']['member']['username']
          user.save

        # if the webhook is telling us that our authorization has been revoked..
        elsif data['type'] == "member.authorization.revoked"

          # destroy the user.
          user.destroy

        # if the webhook is telling us that the parent of an under-13 user has
        # denied our ability to see personal information for this user..
        elsif data['type'] == "member.authorization.rejected"

          # destroy the user.
          user.destroy

        end

      end

    end

    # communicate back to kpass that we've received the webhook.
    render json: [true]

  end

  # helper function to generate a random username use inbetween when an
  # under-13 user authorizes the app with kpass and when their parent authorizes
  # the sharing of their kpass username.
  def random_username
    "chatter-#{(rand * 10000).to_i}"
  end

end
