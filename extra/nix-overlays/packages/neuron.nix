{ pkgs }:

let
  neuronSrc = builtins.fetchTarball "https://github.com/srid/neuron/archive/master.tar.gz";
in
  import neuronSrc {}
