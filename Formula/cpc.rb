class Cpc < Formula
  include Language::Python::Virtualenv

  desc "CPCReady - Amstrad CPC development tool"
  homepage "https://github.com/CPCReady/cpc"
  url "https://github.com/CPCReady/cpc/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "8a74e3ae994b44cd62095fef0e64a0f7ae9345adbe12c4c4f6f7d4552b8733b7"
  license "MIT"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"cpc", "--version"
  end
end
