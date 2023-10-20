{ config, pkgs, ... }:
{
    home.file."jdks/openjdk8".source = pkgs.jdk8;
    home.file."jdks/openjdk11".source = pkgs.jdk11;
    home.file."jdks/openjdk17".source = pkgs.jdk17;
    
    home.sessionVariables = {
        JAVA_8_HOME = "$HOME/jdks/openjdk8";
        JAVA_11_HOME = "$HOME/jdks/openjdk11";
        JAVA_17_HOME = "$HOME/jdks/openjdk17";
        JAVA_HOME = "$JAVA_17_HOME";
    };

    home.packages = with pkgs; [
        maven
        gradle
        jetbrains.idea-community
        java-language-server
        jdt-language-server
    ];
}
