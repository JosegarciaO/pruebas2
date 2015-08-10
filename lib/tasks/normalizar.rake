# -*- coding: utf-8 -*-

require 'csv'
namespace :normalizar do

  desc "Normalizar Roles de Usuarios Tecnicos"
  task :roles_tecnicos => :environment do
    # Determinar el rol del tecnico
    if tecnico = Role.find_by_permalink("tecnico")
      
      # pasar todos los usuarios con rol de operador y supervisor a tecnico
      if operador   = Role.find_by_permalink("operador")
        User.where(:role_id => operador.id).each do |rec|
          rec.role_id = tecnico.id
          rec.save
        end
        operador.destroy
      end

      if supervisor = Role.find_by_permalink("supervisor")
        User.where(:role_id => supervisor.id).each do |rec|
          rec.role_id = tecnico.id
          rec.save
        end
        supervisor.destroy
      end

    end
  end

  

end