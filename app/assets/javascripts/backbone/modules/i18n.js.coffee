Modules.I18n =

  locale   : CertOrbe.Config.locale()

  messages : ->
    CertOrbe.Locales[@locale]

  t: (route = "", options = {}) ->
    messages = @messages() || {}
    keys     = route.split(".")

    for key in keys
      if messages[key]? then messages = messages[key]
      else messages = key

    messages = messages.supplant(options) unless _.isEmpty(options)
    messages

  instanceMethods:

    t: (route = "", options = {}) ->
      Modules.I18n.t route, options

    # Falsh Messages
    flash: (type, messages = "", alertsContainer = "#alerts_container") ->
      if _.include CertOrbe.Config.flashes, type
        if _.isString messages
          messages = {messages: [{message: messages}]}

        flashTemplate = "render_#{type}".toCamelize("lower")
        CertOrbe.Helpers[flashTemplate]? messages, alertsContainer
