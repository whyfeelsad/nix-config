let
  mode = "0700";
  genDir = directory: {inherit directory mode;};
in [
  (genDir ".gnupg")
  (genDir ".ssh")
]
