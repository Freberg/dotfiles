{ pkgsUnstable, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    environmentVariables = {
      OLLAMA_KV_CACHE_TYPE = "q8_0";
      OLLAMA_FLASH_ATTENTION = "1";
    };
  };

  home.packages = [
    pkgsUnstable.opencode
  ];
}
