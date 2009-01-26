class Admin::CategoriesController < ApplicationController
  active_scaffold :category
  layout 'admin'
end
