{pkgs, ...}: {
  # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
  id = 0; # 0 is the default profile; see also option "isDefault"
  name = "iain"; # name as listed in about:profiles
  isDefault = true; # can be omitted; true if profile ID is 0

  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    vimium
    sidebery
    proton-pass
    ublock-origin
    privacy-badger
    onepassword-password-manager
  ];

  settings = import ./settings.nix;
  userChrome = builtins.readFile ./userChrome.css;
  search = import ./search-engines.nix {inherit pkgs;};
}
