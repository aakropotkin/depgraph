{ stdenv, lib, autoreconfHook, ak-core, graphviz, makeWrapper }:
let
  buildInputs = [graphviz ak-core];
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
