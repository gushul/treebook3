# Be sure to restart your server when you modify this file.

module StateMachine
  module Integrations
     module ActiveModel
        public :around_validation
     end

     module ActiveRecord
        public :around_save
     end
  end
end
