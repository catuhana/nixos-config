{ ... }:
{
  security = {
    apparmor.enable = true;
    polkit.enable = true;
    rtkit.enable = true;

    sudo.enable = false;
    sudo-rs.enable = true;

    # confinement.enable = true;

    tpm2 = {
      enable = true;
      abrmd.enable = true;
      pkcs11.enable = true;

      tctiEnvironment = {
        enable = true;
        interface = "tabrmd";
      };
    };
  };
}
