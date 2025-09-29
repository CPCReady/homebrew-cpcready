class CpcreadyTools < Formula
  desc "CPCReady Tools"
  homepage "https://github.com/CPCReady/homebrew-cpcready"
  version "1.0.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/CPCReady/idsk/releases/download/v1.0.2/iDSK-mac-arm64"
      sha256 "ec9e567c520ae5ff395abe904c1b2684e222b2369094589e3a5ffaa4a07032d8"
    elsif Hardware::CPU.intel?
      url "https://github.com/CPCReady/idsk/releases/download/v1.0.2/iDSK-mac-x86_64"
      sha256 "9f4aec81a8552879a835f0ed1d0ba341ae9d390389037fa32a00d47889a26036"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/CPCReady/idsk/releases/download/v1.0.2/iDSK-mac-arm64"
      sha256 "ec9e567c520ae5ff395abe904c1b2684e222b2369094589e3a5ffaa4a07032d8"
    elsif Hardware::CPU.intel?
      url "https://github.com/CPCReady/idsk/releases/download/v1.0.2/iDSK-linux-x86_64"
      sha256 "e07e1042bcfa1ac0b8871b07afb07aba3d90692168f4dbaa26ecc11ce6e16d1d"
    end
  end

  resource "cpc-update-var" do
    url "https://github.com/CPCReady/cpc-update-var/releases/download/v0.1.2/cpc-update-var"
    sha256 "3293825eff99965331401a3c0ab23924eee2d44ecf73ab36e36102512545b2b4"
  end

  resource "cpc-common.sh" do
    url "https://github.com/CPCReady/cpc-common/releases/download/v0.0.2/cpc-common.sh"
    sha256 "d255695ff41d47e904ca41b7c7743fe6858a0722a16c4a71321bc51ea8d45e82"
  end

  resource "cpc-ini" do
    url "https://github.com/CPCReady/cpc_ini/archive/refs/tags/0.0.1.tar.gz"
    sha256 "3a040756bc225d7587dec88d7fe5c947f805d966b6e89d54f3f358de879e0505"
  end

  depends_on "gum"
  depends_on "yq"
  depends_on "jq"
  depends_on "direnv"
  depends_on "inih"

  def install
    # Instalar iDSK
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "iDSK-mac-arm64" => "idsk"
      elsif Hardware::CPU.intel?
        bin.install "iDSK-mac-x86_64" => "idsk"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "iDSK-mac-arm64" => "idsk"
      elsif Hardware::CPU.intel?
        bin.install "iDSK-linux-x86_64" => "idsk"
      end
    end

    # Instalar cpc-update-var
    resource("cpc-update-var").stage do
      bin.install "cpc-update-var"
    end

    # Instalar cpc-common.sh
    resource("cpc-common.sh").stage do
      libexec.install "cpc-common.sh"
    end

    # Compilar e instalar cpc_ini
    resource("cpc-ini").stage do
      system "gcc", "-I#{Formula["inih"].opt_include}", "-L#{Formula["inih"].opt_lib}",
             "-o", "cpc-ini", "main.c", "-linih"
      bin.install "cpc-ini"
    end
  end

  test do
    system bin/"idsk", "--version"
    system bin/"cpc-update-var", "--version"
    assert_predicate libexec/"cpc-common.sh", :exist?, "cpc-common.sh no se instaló correctamente"
    system "#{bin}/cpc-ini", "--help"  # o algún test simple de cpc_ini
  end
end