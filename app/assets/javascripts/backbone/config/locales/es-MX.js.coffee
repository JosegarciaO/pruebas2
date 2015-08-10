CertOrbe.Locales["es-MX"] =
  errorsMessages:
    inclusion: "no está incluído en la lista"
    exclusion: "está reservado"
    invalid: "es inválido"
    record_invalid: "es inválido"
    invalid_date: "es una fecha inválida"
    confirmation: "no coincide con la confirmación"
    blank: "no puede estar en blanco"
    empty: "no puede estar vacío"
    not_a_number: "no es un número"
    taken: "ya ha sido tomado"
    less_than: "debe ser menor que %{count}"
    less_than_or_equal_to: "debe ser menor o igual que %{count}"
    greater_than: "debe ser mayor que %{count}"
    greater_than_or_equal_to: "debe ser mayor o igual que %{count}"
    too_short:
      one: "es demasiado corto (mínimo 1 caracter)"
      other: "es demasiado corto (mínimo %{count} caracteres)"
    too_long:
      one: "es demasiado largo (máximo 1 caracter)"
      other: "es demasiado largo (máximo %{count} caracteres)"
    equal_to: "debe ser igual a %{count}"
    wrong_length:
      one: "longitud errónea (debe ser de 1 caracter)"
      other: "longitud errónea (debe ser de %{count} caracteres)"
    accepted: "debe ser aceptado"
    even: "debe ser un número par"
    odd: "debe ser un número non"
    invalid_email: "no es una dirección de correo electrónico válida"

  helpers:
    booleans:
      "true": "Sí"
      "false": "No"
    new:
      success: "%{model_name} se guardo exitosamente"
    edit:
      success: "%{model_name} se actualizo exitosamente"

  select:
    prompt: "- Seleccione -"

  insurance_coverages:
    deductible_min: "% Deducible"
    coverage_id: "Cobertura"

  activerecord:
    models:
      user: "Usuario"
      role: "Rol"
      country: "País"
      state: "Estado"
      city: "Ciudad"
      insurance: "Aseguradora"
      insurance_possession: "Bienes por Aseguradora"
      certificate_request: "Solicitud de Certificado"
      certificate_request_coverage: "Cobertura de Certificado"
      policy: "Póliza"
      possession: "Bien"
      coverage: "Cobertura"
      clause: "Cláusula Adicional"
      general_setting: "Configuraciones Generales"
      transportation: "Medios de Transporte"

    attributes:
      user:
        email: "Email"
        role_id: "Rol"
      role:
        name: "Nombre"
      country:
        name: "Nombre"
      state:
        name: "Nombre"
        country_id: "País"
      city:
        name: "Nombre"
        state_id: "Estado"
      insurance:
        name: "Nombre"
        tin: "R.F.C."
        street: "Calle"
        area: "Colonia"
        zip_code: "Código Postal"
        city_id: "Ciudad"
        state_id: "Estado"
        expedition_fee_mx: "Gastos de Expedición (MN)"
        expedition_fee_us: "Gastos de Expedición (USD)"
        max_amount:  "Suma Asegurada Máxima"
        deductible_text: "Texto Deducible"
        logo: "Logotipo"
        firma1: "Firma 1"
        firma2: "Firma 2"
        deductible_min: "% Deducible"
        coverage_id: "Cobertura"
      insurance_possession:
        max_amount: "Suma Asegurada Máxima"
        possession_id: "Bien"
      insurance_coverages:
        deductible_min: "% Deducible"
        coverage_id: "Cobertura"
      certificate_request:
        num_constancia: "Num. Certificado"
        nombre: "Asegurado"
        direccion: "Dirección Fiscal"
        city_id: "Ciudad"
        cp: "Código Postal"
        rfc: "RFC"
        importe: "Importe Asegurado"
        base_fee: "Cuota Base"
        expedition_fee: "Gastos de Expedición"
        iva: "IVA"
        iva_amount: "Importe IVA"
        total_prime: "Prima Total"
        moneda: "Tipo de Moneda"
        city_from_id: "Ciudad Origen"
        city_to_id: "Ciudad Destino"
        possession_id: "Bienes"
        possession_description: "Descripción detallada"
        packaging: "Embalaje"
        num_invoice: "Factura/Carta Porte"
        fecha_salida: "Fecha de Salida"
        fecha_llegada: "Fecha de Llegada"
        embarque: "Num. de embarque"
        policy_id: "Póliza"
        codigo_seguridad: "Código de Seguridad"
        certificate_request_coverages: "Coberturas de Certificado"
        deducibles: "Deducibles"
        medida_seguridad: "Medidas de Seguridad"
        transport_ground: "Terrestre"
        transport_air: "Aereo"
        transport_maritime: "Marítimo"
        transport_rail: "Ferrocarril"
        transport_package: "Paquetería/Mensajería"
      certificate_request_coverage:
        deductible: "Deducible"
      policy:
        folio: 'Folio'
        moneda: 'Moneda'
        insurance_id: "Aseguradora"
        date_start: "Inicio Vigencia"
        date_end: "Fin Vigencia"
      possession:
        name: "Descripción"
        active: "Activo"
        has_max_amount: "Tiene suma aseg. máxima"
        max_amount: "Suma Asegurada Máxima"
      coverage:
        name: "Descripción"
        active: "Activo"
        deductible_min:  "Deducible Mínimo"
        deductible_editable:  "Deducible Editable"
      clause:
        name: "Nombre"
        isfixed: "Fijo"
        active: "Activo"
      general_setting:
        iva: "IVA"
        base_fee_min: 'Base cuota mínima'
        packaging_default: "Embalaje Default"
        exchange_usd: "Tipo de cambio Dolar"
        medidas_seguridad_default: "Medidas de Seguridad Default"
        certificate_consecutive: "Consecutivo de Certificado"
      transportation:
        name: "Nombre"
