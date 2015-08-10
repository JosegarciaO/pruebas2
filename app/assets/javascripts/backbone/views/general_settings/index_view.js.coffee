CertOrbe.Views.GeneralSettings ||= {}

class CertOrbe.Views.GeneralSettings.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesGeneralSettingsIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.generalSettings.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_general_settings" : "refreshGeneralSettings"

  refreshGeneralSettings: (e) ->
    e.preventDefault()
    @options.generalSettings.fetch()

  addAll: () ->
    @$("#general_settings_table tbody").empty()
    @renderPagination(@options.generalSettings)
    @options.generalSettings.each(@addOne)

  addOne: (generalSetting) ->
    view = new CertOrbe.Views.GeneralSettings.GeneralSettingView({model : generalSetting})
    @$("#general_settings_table tbody").append(view.render().el)

  render: ->
    template = @template(generalSettings: @options.generalSettings.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.generalSettings.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.generalSettings)
