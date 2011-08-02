require 'spree_core'
require 'spree_fbtab_views_hooks'
require 'pp'

module SpreeFbtabViews
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end


module SpreeBase
  module InstanceMethods
    protected
    
    def fbtab?
      if request.POST['signed_request']
        cookies[:fbtab_param] = "1"
        true
      else
        cookies[:fbtab_param] == "1"
      end
      # if cookies[:fbtab_param]
      #   cookies[:fbtab_param] == "1"
      # else
      #   if request.POST['signed_request']
      #     cookies[:fbtab_param] = "1"
      #     true
      #   else
      #     false
      #   end
      # end
    end

    def prepare_for_fbtab
      cookies[:fbtab_param] = params[:fbtab] if params[:fbtab]
    end
    
    def prepend_view_path_if_fbtab
      pp "fbtab?"
      pp fbtab?
      pp "cookies[:fbtab_param]"
      pp cookies[:fbtab_param]
      
      if fbtab?
        prepend_view_path File.join(File.dirname(__FILE__), '..', 'app', 'fbtab_views')
        prepend_view_path File.join(Rails.root, 'app', 'fbtab_views')
      end
    end
  end
  
  class << self

    def included_with_fbtab_views(receiver)
      included_without_fbtab_views(receiver)
      
      receiver.send :helper_method, 'fbtab?'
      receiver.send :before_filter, 'prepare_for_fbtab'
      receiver.send :before_filter, 'prepend_view_path_if_fbtab'
    end
    
    alias_method_chain :included, :fbtab_views
  
  end
end
