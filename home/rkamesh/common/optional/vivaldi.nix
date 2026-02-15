{ pkgs, ... }:
{
  # Vivaldi browser configuration with ERR_NETWORK_CHANGED fixes
  home.file.".config/vivaldi/Default/Preferences" = {
    force = true;
    text = builtins.toJSON {
      # Disable QUIC protocol which can cause ERR_NETWORK_CHANGED
      "net.quic_allowed" = false;

      # Disable network prediction that can trigger false positives
      "net.network_prediction_options" = 0;

      # Use DoH (DNS over HTTPS) for more stable DNS resolution
      "dns_over_https" = {
        mode = 2; # 2 = secure/DoH only
        templates = "https://dns.google/dns-query";
      };

      # Disable automatic proxy detection which can cause network change detection
      "proxy.auto_detect" = false;

      # Disable NTLMv2 authentication that might trigger network issues
      "ntlm_v2_enabled" = false;

      # Enable connection pooling and keep-alive
      "net.http_pipelining" = true;
      "net.http_pipelining_max_requests" = 8;

      # Increase network timeout tolerances
      "net.timeout_hangup_http_keep_alive" = 60;
    };
  };

  # Additional environment variables for network stability
  home.sessionVariables = {
    # Disable IPv6 if it's causing issues (can comment out if not needed)
    # "VIVALDI_DISABLE_IPV6" = "1";
  };
}
