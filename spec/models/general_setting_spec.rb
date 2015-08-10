require 'spec_helper'

describe GeneralSetting do
	it "Allows build a new GeneralSetting model" do
		expect(FactoryGirl.build(:general_setting)).to be_valid
	end

	it "Is invalid without iva" do
		rec = FactoryGirl.build(:general_setting, iva: nil)
		expect(rec).to have_at_least(1).errors_on(:iva)
	end

	it "Is invalid with iva equals to 0" do
		rec = FactoryGirl.build(:general_setting, iva: 0)
		expect(rec).to have_at_least(1).errors_on(:iva)
	end

	it "Is invalid with iva less than 0" do
		rec = FactoryGirl.build(:general_setting, iva: -1)
		expect(rec).to have_at_least(1).errors_on(:iva)
	end

	it "Is invalid with iva greater to 100" do
		rec = FactoryGirl.build(:general_setting, iva: 101)
		expect(rec).to have_at_least(1).errors_on(:iva)
	end

	it "Is invalid without base_fee_min" do
		rec = FactoryGirl.build(:general_setting, base_fee_min: nil)
		expect(rec).to have_at_least(1).errors_on(:base_fee_min)
	end

	it "Is invalid with base_fee_min equals to 0" do
		rec = FactoryGirl.build(:general_setting, base_fee_min: 0)
		expect(rec).to have_at_least(1).errors_on(:base_fee_min)
	end

	it "Is invalid with base_fee_min less than 0" do
		rec = FactoryGirl.build(:general_setting, base_fee_min: -1)
		expect(rec).to have_at_least(1).errors_on(:base_fee_min)
	end

	it "Is invalid without exchange_usd" do
		rec = FactoryGirl.build(:general_setting, exchange_usd: nil)
		expect(rec).to have_at_least(1).errors_on(:exchange_usd)
	end

	it "Is invalid with exchange_usd equals to 0" do
		rec = FactoryGirl.build(:general_setting, exchange_usd: 0)
		expect(rec).to have_at_least(1).errors_on(:exchange_usd)
	end

	it "Is invalid with exchange_usd less_than 0" do
		rec = FactoryGirl.build(:general_setting, exchange_usd: -1)
		expect(rec).to have_at_least(1).errors_on(:exchange_usd)
	end

	it "Is invalid with base_fee_min greater to 100" do
		rec = FactoryGirl.build(:general_setting, base_fee_min: 101)
		expect(rec).to have_at_least(1).errors_on(:base_fee_min)
	end

	it "Is invalid adding a second model" do
		FactoryGirl.create(:general_setting)
		rec = FactoryGirl.build(:general_setting)
		expect(rec).to be_invalid
	end


	# -- Metodos de Clase

	it "Is valid on getBaseFeeMin equals to 12" do
		rec = FactoryGirl.create(:general_setting, base_fee_min: 0.12)
		expect(GeneralSetting::getBaseFeeMin).to eq(0.12)
	end

	it "Is valid on getIVA equals to 16" do
		rec = FactoryGirl.create(:general_setting, iva: 16)
		expect(GeneralSetting::getIVA).to eq(16)
	end

	it "Is valid on getPackagingDefault equals to 'Embalaje Default'" do
		rec = FactoryGirl.create(:general_setting, packaging_default: 'Embalaje Default')
		expect(GeneralSetting::getPackagingDefault).to eq('Embalaje Default')
	end

	it "Is valid on getTipoCambio equals to 13" do
		rec = FactoryGirl.create(:general_setting, exchange_usd: 13)
		expect(GeneralSetting::getTipoCambio).to eq(13)
	end

	it "Is valid on getMedidasSeguridadDefault equals to 'Texto medidas de seguridad'" do
		rec = FactoryGirl.create(:general_setting, medidas_seguridad_default: 'Texto medidas de seguridad')
		expect(GeneralSetting::getMedidasSeguridadDefault).to eq('Texto medidas de seguridad')
	end

	it "Is valid on get_deducible_default equals to 'Texto deducible'" do
		rec = FactoryGirl.create(:general_setting, deducible_default: 'Texto deducible')
		expect(GeneralSetting::get_deducible_default).to eq('Texto deducible')
	end

	it "Is valid on next_certificate_consecutive equals to 2" do
		rec = FactoryGirl.create(:general_setting, certificate_consecutive: 1)
		expect(GeneralSetting::next_certificate_consecutive).to eq(2)
	end

end
