{ pkgs }:

let
  version = "0.6.0.0";
  neuronSrc = builtins.fetchTarball "https://github.com/srid/neuron/archive/${version}.tar.gz";
in
  import neuronSrc {}
