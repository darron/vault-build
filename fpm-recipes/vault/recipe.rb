class Vault < FPM::Cookery::Recipe
  name 'vault'

  version '0.2.0'
  revision '1'
  description 'Vault'

  homepage 'https://www.vaultproject.io/'
  source "https://dl.bintray.com/mitchellh/vault/vault_#{version}_linux_amd64.zip"
  sha256 'b4b64fcea765ebfc7cdbae9cdd2c32bff130ca51f15b9cf47194f112fd5515cf'

  maintainer 'Darron Froese <darron@froese.org>'
  vendor 'octohost'

  license 'Mozilla Public License, version 2.0'

  conflicts 'vault'
  replaces 'vault'

  build_depends 'unzip'

  def build
    safesystem "mkdir -p #{builddir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/vault_#{version}_linux_amd64/vault #{builddir}/usr/local/bin/"
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "mkdir -p #{destdir}/etc/vault/"
    safesystem "cp -f #{builddir}/usr/local/bin/vault #{destdir}/usr/local/bin/vault"
    etc('vault').install_p workdir('vault.hcl'), 'vault.hcl'
    etc('init').install_p workdir('vault.upstart'), 'vault.conf'
    etc('default').install_p workdir('vault.default'), 'vault'
  end
end
