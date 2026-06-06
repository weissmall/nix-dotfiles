{ ... }:
{
  powerManagement.resumeCommands = ''
    pkill quickshell
    command -v noctalia-shell && noctalia-shell
  '';
}
