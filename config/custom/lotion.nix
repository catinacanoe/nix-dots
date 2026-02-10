{ buildNpmPackage, fetchFromGitHub, makeWrapper, nodejs, electron }:
let
    pname = "lotion";
    version = "v1.5.0";
in
    buildNpmPackage {
        inherit pname version;

        # https://github.com/puneetsl/lotion/archive/refs/tags/v1.5.0.tar.gz
        src = fetchFromGitHub {
            owner = "puneetsl";
            repo = "lotion";
            rev = "${version}";
            sha256 = "0j6sxxxcnlmx4s2mb8pq1w8xgbm32ffng3nsdcvpsksahwh5rsm0";
        };

        npmDepsHash = "sha256-sZSsKLKGDRB1uCJrLUE23j6Qi+B13YP6OP2j0ZE6+V8=";

        nativeBuildInputs = [
            nodejs
            electron
            makeWrapper
        ];

        buildInputs = [
            electron
        ];

        env = {
            ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
            ELECTRON_FORCE_IS_PACKAGED = "true";
            ELECTRON_OVERRIDE_DIST_PATH = "${electron}/lib/electron";
            ELECTRON_OVERRIDE_EXEC_PATH = "${electron}/bin/electron";

            npm_config_electron_skip_binary_download = "true";
            npm_config_build_from_source = "true";
        };

        makeCacheWritable = true;
        dontNpmBuild = true;

        installPhase = ''
            runHook preInstall

            echo "copying app to $out/lib"
            mkdir -p $out/lib/${pname}
            cp -r . $out/lib/${pname}

            echo "using makewrapper to create binary in $out/bin"
            mkdir -p $out/bin/
            makeWrapper ${electron}/bin/electron $out/bin/${pname} \
                --add-flags $out/lib/${pname}/src/main/index.js

            runHook postInstall
        '';
    }
