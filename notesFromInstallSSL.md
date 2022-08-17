# Running the brew install of openssl

Produced this (Derek's Mac Mini, M1):

...
```
You have 34 outdated formulae and 1 outdated cask installed.
You can upgrade them with brew upgrade
or list them with brew outdated.

openssl@3  is already installed but outdated (so it will be upgraded).
==> Downloading https://ghcr.io/v2/homebrew/core/ca-certificates/manifests/2022-
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/ca-certificates/blobs/sha256:9e
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sh
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/openssl/3/manifests/3.0.5
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/openssl/3/blobs/sha256:d0cc0094
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sh
######################################################################## 100.0%
==> Installing dependencies for openssl@3: ca-certificates
==> Installing openssl@3 dependency: ca-certificates
==> Pouring ca-certificates--2022-07-19_1.all.bottle.tar.gz
==> Regenerating CA certificate bundle from keychain, this may take a while...
🍺  /opt/homebrew/Cellar/ca-certificates/2022-07-19_1: 3 files, 222.6KB
==> Installing openssl@3
==> Pouring openssl@3--3.0.5.arm64_monterey.bottle.tar.gz
==> Caveats
A CA file has been bootstrapped using certificates from the system
keychain. To add additional certificates, place .pem files in
  /opt/homebrew/etc/openssl@3/certs

and run
  /opt/homebrew/opt/openssl@3/bin/c_rehash

openssl@3 is keg-only, which means it was not symlinked into /opt/homebrew,
because macOS provides LibreSSL.

If you need to have openssl@3 first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"' >> ~/.zshrc

For compilers to find openssl@3 you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

==> Summary
🍺  /opt/homebrew/Cellar/openssl@3/3.0.5: 6,444 files, 27.9MB
==> Running `brew cleanup openssl@3`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
Removing: /opt/homebrew/Cellar/openssl@3/3.0.3... (6,441 files, 27.9MB)
Removing: /Users/derekwilliams/Library/Caches/Homebrew/openssl@3--3.0.3... (7.5MB)
==> Not upgrading 1 pinned dependent:
ruby 3.1.2
==> Upgrading 2 dependents of upgraded formula:
Disable this behaviour by setting HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
cocoapods 1.11.2_1 -> 1.11.3, openssl@1.1 1.1.1n -> 1.1.1q
==> Downloading https://ghcr.io/v2/homebrew/core/openssl/1.1/manifests/1.1.1q
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/openssl/1.1/blobs/sha256:4e7b6c
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sh
######################################################################## 100.0%
Error: You must `brew unpin ruby` as installing cocoapods requires the latest version of pinned dependencies
==> Upgrading openssl@1.1
  1.1.1n -> 1.1.1q 

==> Pouring openssl@1.1--1.1.1q.arm64_monterey.bottle.tar.gz
🍺  /opt/homebrew/Cellar/openssl@1.1/1.1.1q: 8,097 files, 18MB
==> Running `brew cleanup openssl@1.1`...
Removing: /opt/homebrew/Cellar/openssl@1.1/1.1.1n... (8,089 files, 18MB)
Removing: /Users/derekwilliams/Library/Caches/Homebrew/openssl@1.1--1.1.1n... (5MB)
==> Checking for dependents of upgraded formulae...
==> No broken dependents found!
==> `brew cleanup` has not been run in the last 30 days, running now...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
Removing: /opt/homebrew/Cellar/ca-certificates/2022-04-26... (3 files, 215.6KB)
Removing: /Users/derekwilliams/Library/Caches/Homebrew/ca-certificates--2022-04-26... (121.8KB)
Removing: /Users/derekwilliams/Library/Caches/Homebrew/ruby_bottle_manifest--3.0.3... (11.6KB)
Removing: /Users/derekwilliams/Library/Caches/Homebrew/cocoapods_bottle_manifest--1.11.2_1... (12.0KB)
Removing: /Users/derekwilliams/Library/Caches/Homebrew/ca-certificates_bottle_manifest--2021-10-26... (1.8KB)
Removing: /Users/derekwilliams/Library/Caches/Homebrew/openssl@1.1_bottle_manifest--1.1.1m... (7.6KB)
Removing: /Users/derekwilliams/Library/Logs/Homebrew/frum... (64B)
Removing: /Users/derekwilliams/Library/Logs/Homebrew/openssl@3... (64B)
Removing: /Users/derekwilliams/Library/Logs/Homebrew/ca-certificates... (64B)
Removing: /Users/derekwilliams/Library/Logs/Homebrew/openssl@1.1... (64B)
Pruned 0 symbolic links and 6 directories from /opt/homebrew
==> Caveats
==> openssl@3
A CA file has been bootstrapped using certificates from the system
keychain. To add additional certificates, place .pem files in
  /opt/homebrew/etc/openssl@3/certs

and run
  /opt/homebrew/opt/openssl@3/bin/c_rehash

openssl@3 is keg-only, which means it was not symlinked into /opt/homebrew,
because macOS provides LibreSSL.

If you need to have openssl@3 first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"' >> ~/.zshrc

For compilers to find openssl@3 you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

derekwilliams@Dereks-Mac-mini flea-market-BE % openssl req -nodes -new -x509 -keyout server.key -out server.cert
Generating a 2048 bit RSA private key
...+++
..................................................+++
writing new private key to 'server.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) []:US
State or Province Name (full name) []:Colorado
Locality Name (eg, city) []:FortCollins
Organization Name (eg, company) []:FoundObjx
Organizational Unit Name (eg, section) []:Development
Common Name (eg, fully qualified host name) []:localhost
Email Address []:derek61@gmail.com
```
