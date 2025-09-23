{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubectl
    k9s
    talosctl
    argocd
    kubernetes-helm
    kind
    kubeseal
  ];
}
