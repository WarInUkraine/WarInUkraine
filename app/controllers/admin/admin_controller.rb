class Admin::AdminController < ApplicationController
  before_filter :admin_user!
end
