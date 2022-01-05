{ stdenv
, lib
, autoreconfHook
, makeWrapper
, ak-core
, graphviz
, coreutils
, gnused
, gawk
, findutils
, diffutils
, gnugrep
, bash
}:
let
  buildInputs = [
    ak-core
    bash
    coreutils
    diffutils
    findutils
    gawk
    gnugrep
    gnused
    graphviz
  ];
in stdenv.mkDerivation {
  pname = "depgraph";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [autoreconfHook makeWrapper];
  inherit buildInputs;
  preFixup = ''
    for f in $( find $out/bin/ -type f -executable ); do
      wrapProgram "$f" --prefix PATH : "${lib.makeBinPath buildInputs}"
    done
  '';
  meta.license = lib.licenses.bsd3;
}
