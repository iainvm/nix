let
  forceInstall = {name}: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
    installation_mode = "force_installed";
  };
in {
  # 1Password
  "{d634138d-c276-4fc8-924b-40a0ea21d284}" = forceInstall {name = "1password-x-password-manager";};
  # Sideberry
  "{3c078156-979c-498b-8990-85f7987dd929}" = forceInstall {name = "sidebery";};
  # uBlock Origin
  "uBlock0@raymondhill.net" = forceInstall {name = "ublock-origin";};
  # Privacy Badger
  "jid1-MnnxcxisBPnSXQ@jetpack" = forceInstall {name = "privacy-badger17";};
  # Vimium
  "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = forceInstall {name = "vimium-ff";};
}
