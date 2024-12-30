{ pkgs, ... }:
{
    home.packages = with pkgs; [
        nixd
        jdt-language-server
        kotlin-language-server
    ];
    programs.zed-editor = {
        enable = true;
        extensions = [ "nord" "dockerfile" "nix" "java" "kotlin" ];
        userSettings = {
            vim_mode = true;
            theme = {
                mode = "dark";
                dark = "Nord";
                light = "Nord Light";
            };
            assistant = {
                enabled = true;
            };
            lsp = {
                nixd = {
                    binary = {
                        path_lookup = true;
                    };
                };
                jdtls = {
                    binary = {
                        path_lookup = true;
                    };
                    initialization_options = {
                        settings = {
                            java = {
                                import = {
                                    gradle = {
                                        enabled = true;
                                    };
                                    maven = {
                                        enabled = true;
                                    };
                                };
                            };
                        };
                    };
                };
                kotlin-language-server = {
                    binary = {
                        path_lookup = true;
                    };
                    settings = {
                        compiler = {
                            jvm = {
                                target = "17";
                            };
                        };
                    };
                };
            };
            languages = {
                Nix = {
                    language_servers = [ "nixd" "!nil" ];
                };
                Java = {
                    language_servers = [ "jdtls" ];
                };
                Kotlin = {
                    language_servers = [ "kotlin-language-server" ];
                };
            };
        };
    };
}
