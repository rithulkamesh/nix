# audio.nix
#
# This module configures audio for the system using PipeWire instead of PulseAudio.
# PipeWire provides better compatibility with various audio systems and applications
# while offering improved performance and stability.

{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Disable PulseAudio in favor of PipeWire
  hardware.pulseaudio.enable = false;

  # Enable RealtimeKit to allow PipeWire to operate with realtime privileges
  security.rtkit.enable = true;

  # PipeWire configuration
  services.pipewire = {
    enable = true; # Enable PipeWire service
    alsa.enable = true; # ALSA support
    alsa.support32Bit = true; # Support for 32-bit ALSA applications
    pulse.enable = true; # PulseAudio compatibility
    jack.enable = true; # JACK audio server compatibility
    # Uncomment the following line if you need the legacy media session
    # media-session.enable = true;
  };
}
