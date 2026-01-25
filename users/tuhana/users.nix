# TODO: Maybe flatten `users/<home>/*.nix` into a
# single `users/<home>.nix` file?
_: {
  users.users.tuhana = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
