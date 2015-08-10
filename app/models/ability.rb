class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    $user = user

    if user.admin?
        can :manage, :all
    else
        can :read, [City, State, Country, GeneralSetting, Possession, Coverage, Clause, Insurance, InsuranceCoverage, CertificateRequestClause, CertificateRequestCoverage, Policy]
        
        # permisos para cambiar status de Solicitudes de Certificados
        cannot :setRequestCertificate,   CertificateRequest
        cannot :setQuoteCertificate,     CertificateRequest
        cannot :setAuthorizeCertificate, CertificateRequest
        cannot :setSealCertificate,      CertificateRequest
        cannot :setCancelCertificate,    CertificateRequest

        # permisos para reporteador
        cannot :read, :report
        cannot :report_certificates, :report

        if user.aduana?
            can [:read,:create,:update],  CertificateRequest
            can :setRequestCertificate,   CertificateRequest
            # -- No puede Cotizar  --
            can :setAuthorizeCertificate, CertificateRequest
            # -- No puede Emitir   --
            # -- No puede Cancelar --
        end

        if user.tecnico?
            can [:read,:create,:update], CertificateRequest
            can :setRequestCertificate,  CertificateRequest
            can :setQuoteCertificate,  CertificateRequest
            # -- No puede Autorizar --
            can :setSealCertificate,   CertificateRequest
            #can :setCancelCertificate, CertificateRequest
            #Autorizar cotizaciones
            can :setAuthorizeCertificate, CertificateRequest
            #
           # can :setSealCertificate,      CertificateRequest

            can :seeBaseFee, CertificateRequest

            can :read, :report
            can :report_certificates, :report
        end

    end

    # -- Accesos totalmente restringidos --
    cannot [:create,:destroy], Role
    cannot :destroy, GeneralSetting
    cannot :destroy, CertificateRequest


    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
