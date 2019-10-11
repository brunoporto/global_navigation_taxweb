SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = GlobalNavigationRenderer

  navigation.items do |navigation_bar|
    navigation_bar.item :logo, nil, root_path, src: asset_path("logo.png")
    navigation_bar.item :profile, nil, root_path, src: asset_path(current_user.avatar)

    navigation_bar.item :apps, nil, apps_path, fa_icon: 'star', position: :primary do |navigation_menu|
      navigation_menu.item :new_app, "Novo Apps", new_app_path
      
    end

    navigation_bar.item :users, nil, users_path, fa_icon: 'users', position: :primary do |navigation_menu|
      navigation_menu.item :new_user, "Novo User", edit_user_path(current_user), fa_icon: 'user'
    end

    navigation_bar.item :plus, nil, root_path, fa_icon: 'plus', position: :primary
    
    navigation_bar.item :bell, nil, organizations_path, fa_icon: 'bell', position: :secondary
    navigation_bar.item :th, nil, root_path, fa_icon: 'th', position: :secondary
    navigation_bar.item :question_circle, nil, root_path, fa_icon: 'question-circle', position: :secondary
    navigation_bar.item :cog, nil, root_path, fa_icon: 'cog', position: :secondary


    # primary.item :dashboards, "Painel", root_path, link_html: {icon: "widgets"} do |sub_nav|
    #   sub_nav.item :ds_indicators, t(:dashboard_label), dashboard_path, {}
    # end

    # primary.item :users, User.model_name.human(count: 2), nil, link_html: {icon: "group"} do |sub_nav|
    #   sub_nav.item :users_invite, I18n.t(:invite), new_organization_invite_user_path(current_organization) if current_organization && can?(:invite_users, current_organization)
    #   sub_nav.item :users_authorize, I18n.t(:authorize_access), organization_user_authorizations_path(current_organization) if current_organization && can?(:authorize_users, current_organization)
    #   sub_nav.item :users_search, I18n.t(:search_in_organization), organization_users_path(current_organization) if current_organization && can?(:index, OrganizationUser, {organization_id: current_organization&.id})
    #   sub_nav.item :users_search, I18n.t(:search_all), users_path if can?(:index, User)
    # end

    # primary.item :accounts, Account.model_name.human(count: 2), nil, link_html: {icon: "folder_shared"} do |sub_nav|
    #   sub_nav.item :accounts_create, I18n.t(:new_a), new_organization_account_path(current_organization) if current_organization && can?(:create, Account, {organization_id: current_organization&.id})
    #   sub_nav.item :accounts_search, I18n.t(:search), organization_accounts_path(current_organization) if current_organization && can?(:index, Account, {organization_id: current_organization&.id})
    # end

    # primary.item :organization, Organization.model_name.human, nil, link_html: {icon: "home_work"} do |sub_nav|
    #   sub_nav.item :organization_show, I18n.t(:show_current), organization_path(current_organization) if current_organization && can?(:show, current_organization)
    #   sub_nav.item :organization_saml, I18n.t(:configure_saml_access), saml_organization_path(current_organization) if current_organization && can?(:manage_saml, current_organization)
    #   sub_nav.item :organization_change, I18n.t(:switch_organization), select_organizations_path if can?(:select, Organization)
    #   sub_nav.item :organization_search, I18n.t(:search), organizations_path if can?(:index, Organization)
    # end

    # primary.item :apps, App.model_name.human(count: 2), nil, link_html: {icon: "important_devices"} do |sub_nav|
    #   sub_nav.item :apps_search, I18n.t(:search), apps_path if can?(:index, App)
    #   sub_nav.item :apps_create, I18n.t(:new), new_app_path if can?(:create, App)
    #   sub_nav.item :apps_documents, I18n.t(:documents), app_documents_path if can?(:index, AppDocument)
    # end

    # if current_user.admin?
    #   primary.item :backoffice, t(:backoffice), nil, link_html: {icon: "settings"} do |sub_nav|
    #     sub_nav.item :bo_dashboard, t(:dashboard_label), admin_dashboard_path
    #     sub_nav.item :bo_accounts, Account.model_name.human(count: 2), admin_accounts_path
    #     sub_nav.item :bo_users, User.model_name.human(count: 2), admin_users_path
    #     sub_nav.item :bo_service, t(:services), admin_services_path
    #     sub_nav.item :bo_account_indicators, t(:account_indicators), admin_indicators_path(subject: "accounts")
    #     sub_nav.item :bo_billing_indicators, t(:billing_indicators), admin_indicators_path(subject: "billing")
    #     sub_nav.item :bo_background_jobs, t(:background_jobs), delayed_job_path, target: "_blank"
    #     sub_nav.item :bo_api, t(:api), swagger_ui_engine_path, target: "_blank"
    #   end
    # end
  end
end
