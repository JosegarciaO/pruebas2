# -*- coding: utf-8 -*-

require 'csv'
namespace :initialize do

  desc "Cargar informacion inicial"
  task :information => :environment do
    Rake::Task['initialize:roles'].execute
    Rake::Task['initialize:admin'].execute
    Rake::Task['initialize:estados_ciudades'].execute
    Rake::Task['initialize:coverages'].execute
    Rake::Task['initialize:clauses'].execute
    Rake::Task['initialize:possessions'].execute
    Rake::Task['initialize:set_paises'].execute
    Rake::Task['initialize:transportations'].execute
  end

  desc "Create Roles"
  task :roles => :environment do
    if Role.count <= 0
      puts "- Creating Roles"
      Role.find_or_create_by_permalink(name:'ADMINISTRADOR', permalink:'admin')
      Role.find_or_create_by_permalink(name:'TECNICO', permalink:'tecnico')
      Role.find_or_create_by_permalink(name:'USUARIO DE ADUANA', permalink:'aduana')
    end
  end

  desc "Create Admin User"
  task :admin => :environment do
    if role = Role.find_by_permalink("admin") and User.count <= 0
      puts "- Creating Admin User"
      admin = User.find_or_create_by_email(email:'admin@agilekoding.com', password:'admin9010', password_confirmation:'admin9010', role_id:role.id)
    end
  end

  desc "Create States/Cities for Mexico"
  task :estados_ciudades => :environment do
    if Country.count == 0

      # --- Crear Pais Mexico ---
      mexico = Country.create(:name => 'MEXICO')

      # --- Estados ---
      puts "- Creating States"
      csv_file = "public/csv_data/estados_orbe.csv"
      csv = CSV.parse(File.read(csv_file), :headers => true)
      csv.each do |row|
          State.create(:name => row[0], :country_id => mexico.id)
      end

      # --- Ciudades ---
      if City.count <= 0
        csv_file = "public/csv_data/ciudades_orbe.csv"
        csv = CSV.parse(File.read(csv_file), :headers => true)
        estado_actual = ''
        rec_estado = nil
        csv.each do |row|
            if estado_actual != row[1]
                puts "- Creating Cities for "+ row[1]
                rec_estado = State.find_by_name(row[1])
                estado_actual = row[1]
            end
            if rec_estado
                City.create(:name => row[0], :state_id => rec_estado.id)
            end
        end
      end

    end
  end

  desc "Create Coverages"
  task :coverages => :environment do
    if Coverage.count <= 0
      puts "- Creating Coverages"
      csv_file = "public/csv_data/coberturas_orbe.csv"
      csv = CSV.parse(File.read(csv_file), :headers => true)
      csv.each do |row|
        Coverage.create(:name => row[0], :deductible_min => row[1])
      end
    else
      puts "- Abort: There are already Coverages"
    end
  end

  desc "Create Clauses"
  task :clauses => :environment do
    if Clause.count <= 0
      puts "- Creating Clauses"
      csv_file = "public/csv_data/clausulas_orbe.csv"
      csv = CSV.parse(File.read(csv_file), :headers => true)
      csv.each do |row|
        Clause.create(:name => row[0], :isfixed => row[1])
      end
    else
      puts "- Abort: There are already Clauses"
    end
  end

  desc "Create Possessions"
  task :possessions => :environment do
    if Possession.count <= 0
      puts "- Creating Possessions"
      csv_file = "public/csv_data/bienes_orbe.csv"
      csv = CSV.parse(File.read(csv_file), :headers => true)
      csv.each do |row|
        Possession.create(:name => row[0])
      end
    else
      puts "- Abort: There are already Possessions"
    end
  end

  desc "Create Countries USA/Canada"
  task :set_paises => :environment do

    # -- Estados/Ciudades de USA
    country_name = "ESTADOS UNIDOS DE AMERICA"
    unless Country.find_by_name(country_name)
      puts "- Creating States/Cities of USA"
      state = nil
      state_name = nil
      country = Country.create(:name => country_name)
      csv = CSV.parse(File.read("public/csv_data/geography_usa.csv"), :headers => false)
      csv.each do |row|
        if state_name != row[0].strip()
          puts "--- Creating State " + row[0].strip()
          state_name = row[0].strip()
          state = State.create(:name => state_name, :country_id => country.id)
        end
        City.create(:name => row[1], :state_id => state.id)
      end
    end

    # -- Estados/Ciudades de Canada
    country_name = "CANADA"
    unless Country.find_by_name(country_name)
      puts "- Creating States/Cities of Canada"
      state = nil
      state_name = nil
      country = Country.create(:name => country_name)
      csv = CSV.parse(File.read("public/csv_data/geography_canada.csv"), :headers => false)
      csv.each do |row|
        if state_name != row[0].strip
          puts "--- Creating State " + row[0].strip()
          state_name = row[0].strip()
          state = State.create(:name => state_name, :country_id => country.id)
        end
        City.create(:name => row[1], :state_id => state.id)
      end
    end

    # -- Estados/Ciudades de China
    country_name = "CHINA"
    unless Country.find_by_name(country_name)
      puts "- Creating States/Cities of China"
      state = nil
      state_name = nil
      country = Country.create(:name => country_name)
      csv = CSV.parse(File.read("public/csv_data/geography_china.csv"), :headers => false)
      csv.each do |row|
        if state_name != row[0].strip
          puts "--- Creating State " + row[0].strip()
          state_name = row[0].strip()
          state = State.create(:name => state_name, :country_id => country.id)
        end
        City.create(:name => row[1], :state_id => state.id)
      end
    end

  end

  desc "Create Transportations"
  task :transportations => :environment do
    if Transportation.count <= 0
      puts "- Creating Transportations"
      ['Terrestre', 'Aéreo', 'Marítimo', 'Ferrocarril', 'Paquetería/Mensajería'].each do |transportation|
        Transportation.create(:name => transportation)
      end
    else
      puts "- Abort: There are already Transportations"
    end
  end

end