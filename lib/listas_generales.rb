class ListasGenerales
  MONEDAS = [{:id => 'M', :name => 'MN'},{:id => 'U', :name => 'USD'}]
  
  STATUS  = [  # para los states de las solicitudes de certificado
    {:id => 1, :name => 'SOLICITADO'},
    {:id => 2, :name => 'COTIZADO'},
    {:id => 3, :name => 'AUTORIZADO'},
    {:id => 4, :name => 'EMITIDO'}
  ]

  def self.getMonedas
    MONEDAS.map { |m| [m[:name], m[:id]] }
  end

  def self.getNombreMoneda(id)
    rec = MONEDAS.detect { |m| m[:id] == id }
    rec[:name] if rec
  end

  def self.get_all_status
    STATUS.map { |s| [s[:name], s[:id]] }
  end

  def self.getNombreStatus(id)
    rec = STATUS.detect { |m| m[:id] == id}
    rec[:name] if rec
  end

end