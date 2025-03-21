{
  lib,
  stdenvNoCC,
  zig_0_13,
  fetchFromGitHub,
  android-tools,
  libinput,
  callPackage,
}:
stdenvNoCC.mkDerivation {
  pname = "droidux";
  version = "572f903";

  src = fetchFromGitHub {
    owner = "leath-dub";
    repo = "droidux";
    rev = "572f903901aadefe35a880187712fac442561b22";
    sha256 = "sha256-beijaXRm1tdTMswTCQWxDPl46e18sl0g0KlLdq1/Knk=";
  };

  nativeBuildInputs = [
    zig_0_13
  ];
  buildInputs = [
    android-tools
    libinput
  ];

  postPatch = ''
    mkdir -p .cache
    ln -s ${callPackage ./deps.nix {}} .cache/p
  '';

  buildPhase = ''
    mkdir -p $out
    zig build install --global-cache-dir $(pwd)/.cache --prefix $out -Doptimize=ReleaseFast
  '';

  meta = with lib; {
    homepage = "https://github.com/leath-dub/droidux";
    description = "Let your Linux device inherit the hardware components of your android device.";
    license = licenses.mit;
    platforms = ["aarch64-linux" "x86_64-linux"];
  };
}
