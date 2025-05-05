{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubectl
    talosctl
    argocd
    kubernetes-helm
    kind
  ];
}
