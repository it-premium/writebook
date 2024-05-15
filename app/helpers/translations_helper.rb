module TranslationsHelper
  TRANSLATIONS = {
    email_address:  { "🇺🇸": "Enter your email address", "🇪🇸": "Introduce tu correo electrónico", "🇫🇷": "Entrez votre adresse courriel", "🇮🇳": "अपना ईमेल पता दर्ज करें", "🇩🇪": "Geben Sie Ihre E-Mail-Adresse ein", "🇧🇷": "Insira seu endereço de email" },
    password: { "🇺🇸": "Enter your password", "🇪🇸": "Introduce tu contraseña", "🇫🇷": "Saisissez votre mot de passe", "🇮🇳": "अपना पासवर्ड दर्ज करें", "🇩🇪": "Geben Sie Ihr Passwort ein", "🇧🇷": "Insira sua senha" },
    user_name: { "🇺🇸": "Enter your name", "🇪🇸": "Introduce tu nombre", "🇫🇷": "Entrez votre nom", "🇮🇳": "अपना नाम दर्ज करें", "🇩🇪": "Geben Sie Ihren Namen ein", "🇧🇷": "Insira seu nome" }
  }

  def translations_for(translation_key)
    tag.dl(class: "language-list") do
      TRANSLATIONS[translation_key].map do |language, translation|
        concat tag.dt(language)
        concat tag.dd(translation, class: "margin-none")
      end
    end
  end

  def translation_button(translation_key)
    tag.div(class: "position-relative", data: { controller: "popup", action: "keydown.esc->popup#close click@document->popup#closeOnClickOutside", popup_orientation_top_class: "popup-orientation-top" }) do
      tag.button(type: "button", class: "btn", tabindex: -1, data: { action: "popup#toggle" }) do
        concat image_tag("globe.svg", size: 20, role: "presentation", class: "color-icon")
        concat tag.span("Translate", class: "for-screen-reader")
      end +
      tag.dialog(class: "lanuage-list-menu shadow", data: { popup_target: "menu" }) do
        translations_for(translation_key)
      end
    end
  end
end
