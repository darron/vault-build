class Vault < FPM::Cookery::Recipe
  name 'vault'

  version '0.7.0'
  revision '1'
  description 'Vault'

  homepage 'https://www.vaultproject.io/'
  source "https://releases.hashicorp.com/vault/#{version}/vault_#{version}_linux_amd64.zip"
  sha256 'c6d97220e75335f75bd6f603bb23f1f16fe8e2a9d850ba59599b1a0e4d067aaa'

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
