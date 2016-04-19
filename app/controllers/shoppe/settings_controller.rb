module Shoppe
  class SettingsController < ApplicationController
    before_filter { @active_nav = :settings }

    def update
      if Shoppe.settings.demo_mode?
        fail Shoppe::Error, t('shoppe.settings.demo_mode_error')
      end

      Shoppe::Setting.update_from_hash(params[:settings].permit!)
      redirect_to :settings, notice: t('shoppe.settings.update_notice')
    end
    def edit
      Shoppe.add_settings_group :system_settings, [:store_address, :store_tel, :short_description]
    end
  end
end
