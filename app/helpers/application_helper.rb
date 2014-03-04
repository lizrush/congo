module ApplicationHelper

  def signed_in?
    if cookies[:user_id] != nil
    end
    cookies[:user_id] != nil && User.find(cookies[:user_id].to_i).remember_token == cookies[:remember_token]
  end

  def current_user
    User.find(cookies[:user_id])
  end


  # User signs in, a cookie gets placed for the long term.
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    cookies.permanent[:user_id] = user.id
    user.update_attribute(:remember_token, remember_token)
  end

  def total(price, qty)
    price * qty
  end

 def only_us_and_canada
  countries = Carmen::Country.all.select{|c| %w{US CA}.include?(c.code)}
  country_codes = []
  countries.each do |country|
    country_codes << country.code
  end
  country_codes
 end

 def states
  us_states.concat(ca_provinces)
 end

 def us_states
  us = Carmen::Country.all.find{|c| %w{US}.include?(c.code)}
  states = []
  us.subregions.each do |s|
    states << s.code
  end
  states
 end

 def ca_provinces
  ca = Carmen::Country.all.find{|c| %w{CA}.include?(c.code)}
  provinces = []
  ca.subregions.each do |p|
    provinces << p.code
  end
  provinces
 end
end
