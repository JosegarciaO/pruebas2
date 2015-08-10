class CertOrbe.Models.GeneralSetting extends CertOrbe.Models.BaseModel
  paramRoot: 'general_setting'
  urlRoot: 'general_settings'

  defaults:
    iva: null
    base_fee_min: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  @paramRoot : 'general_setting'
  @urlRoot   : 'general_settings'

class CertOrbe.Collections.GeneralSettingsCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.GeneralSetting
  url   : '/general_settings'
