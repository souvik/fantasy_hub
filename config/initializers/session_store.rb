Rails.application.config.session_store :cookie_store, key: '_fantasy_hub_session',
                                       httponly: true,
                                       expiry_after: 1.day
