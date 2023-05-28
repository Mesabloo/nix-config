{ config, options, lib, pkgs, ... }:

with lib;
{
  config = mkIf config.modules.services.sound.enable {
    xdg.configFile."pipewire/pipewire.conf.d/90-input-denoising.conf".text = ''
        context.modules = [
        {   name = libpipewire-module-filter-chain
            args = {
                node.description =  "Noise Canceling source"
                media.name =  "Noise Canceling source"
                filter.graph = {
                    nodes = [
                        {
                            type = ladspa
                            name = rnnoise
                            plugin = ${pkgs.noise-suppression-for-voice}/lib/ladspa/librnnoise_ladspa.so
                            label = noise_suppressor_mono
                            control = {
                                "VAD Threshold (%)" = 75.0
                                "VAD Grace Period (ms)" = 300
                                "Retroactive VAD Grace (ms)" = 0
                            }
                        }
                    ]
                }
                playback.props = {
                    node.name =  "rnnoise_source"
                    media.class = Audio/Source
                    audio.rate = 48000
                }
                capture.props = {
                    node.name =  "capture.rnnoise_source"
                    node.passive = true
                    audio.rate = 48000
                    node.target = "alsa_input.pci-0000_04_00.6.HiFi__hw_Generic_1__source"
                }
            }
        }
      ]
    '';

  };
}
