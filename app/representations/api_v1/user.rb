module ApiV1::User
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :email
      t.add :password
      t.add :password_confirmation
      t.add :role_id
    end

    api_accessible :list, :extend => :base do |t|
      t.add :role, :template => :base
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
