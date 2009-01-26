class Admin::UsersController < ApplicationController
  active_scaffold :user
  layout 'admin'
end
