{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dive
    kubectl
    k9s
    talosctl
    argocd
    argo-rollouts
    kubernetes-helm
    kind
    kubeseal
  ];
}
