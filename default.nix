{ stdenv, lib, autoreconfHook, ak-core, graphviz, makeWrapper }:
stdenv.mkDerivation {
  pname = "depgraph";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [autoreconfHook makeWrapper];
  buildInputs = [graphviz];
  preFixup = ''
    for f in $( find $out/bin/ -type f -executable ); do
      wrapProgram "$f" --prefix PATH : "${lib.makeBinPath [graphviz]}"
    done
  '';
  meta.license = lib.licenses.bsd3;
}
