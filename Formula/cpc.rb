class Cpc < Formula
  include Language::Python::Virtualenv

  desc "CPCReady - Amstrad CPC development tool"
  homepage "https://github.com/CPCReady/cpc"
  url "https://github.com/CPCReady/cpc/releases/download/v1.0.0/cpcready-1.0.0-py3-none-any.whl"
  sha256 "5c9c4144293e99c354dd7afc6c5bac8c32d8c18ef0f69012d8c295ccd9a64f95"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"cpc", "--version"
  end
end
