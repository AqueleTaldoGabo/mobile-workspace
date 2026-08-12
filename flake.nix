{
  description = "Ambiente de desenvolvimento Mobile";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };

      androidComposition = pkgs.androidenv.composeAndroidPackages {
        buildToolsVersions = [ "30.0.3" "33.0.0" "34.0.0" ];
        platformVersions = [ "31" "33" "34" ];
        abiVersions = [ "x86_64" ];
      };

      androidSdk = androidComposition.androidsdk;
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.flutter
          pkgs.jdk17
          androidSdk
        ];

        shellHook = ''
          export ANDROID_SDK_ROOT="${androidSdk}/share/android-sdk"
          export ANDROID_HOME="$ANDROID_SDK_ROOT"
          export JAVA_HOME="${pkgs.jdk17}"
          
          # Adiciona ferramentas do Android SDK no PATH
          export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"

          echo "Ambiente de Desenvolvimento Mobile (Android) carregado com sucesso!"
        '';
      };
    };
}