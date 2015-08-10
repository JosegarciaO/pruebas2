CertOrbe::Application.routes.draw do

  resources :transportations

  # resources :certificate_request_clauses

  resources :clauses

  resources :countries do
    resources :states
    collection do
      get :getCountryDefault
    end
  end

  resources :general_settings

  resources :users
  devise_for :users, :path => "usuarios", :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  # resources :certificate_request_coverages

  # resources :packagings

  # resources :possession_descriptions

  resources :coverages

  resources :possessions do
    resources :possession_descriptions
  end

  resources :policies do
    collection do
      get  :getPoliciesByCurrency
      get  :getPolizasInfo
      get  :get_policies_by_insurance
    end
  end

  resources :certificate_requests do
    resources :certificate_request_coverages
    resources :certificate_request_clauses
    member do
      get "print/certificado", :action => "print"
    end
    # -- Acciones para cambiar de status las solicitudes de certificado
    collection do
      post :setAuthorizeCertificate
      post :setSealCertificate
      post :setCancelCertificate
    end
  end


  resources :roles

  resources :cities

  resources :states do
    resources :cities
  end

  resources :insurances do
    resources :policies
    resources :insurance_coverages
    resources :insurance_possessions
    resources :annexes
  end

  resources :reports do
    collection do
      get :report_certificates_json
      get :report_certificates
    end
  end



  # resources :insurance_coverages

  # resources :insurance_possessions


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
