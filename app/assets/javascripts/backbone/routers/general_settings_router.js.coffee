class CertOrbe.Routers.GeneralSettingsRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @generalSettings = new CertOrbe.Collections.GeneralSettingsCollection()
    @generalSettings.reset options.generalSettings

  routes:
    "/new"      : "newGeneralSetting"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newGeneralSetting: ->
    @newGeneralSettingView = new CertOrbe.Views.GeneralSettings.NewView(collection: @generalSettings)
    $("#general_settings").html(@newGeneralSettingView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.GeneralSettings.IndexView(generalSettings: @generalSettings)
    $("#general_settings").html(@indexView.render().el)

  show: (id) ->
    general_setting = @generalSettings.get(id)

    if general_setting?
      general_setting.setAllValues()

      @showView = new CertOrbe.Views.GeneralSettings.ShowView(model: general_setting)
      $("#general_settings").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    general_setting = @generalSettings.get(id)

    if general_setting?
      general_setting.setAllValues()

      @editView = new CertOrbe.Views.GeneralSettings.EditView(model: general_setting)
      $("#general_settings").html(@editView.render().el)
    else @resourceNotFound()
