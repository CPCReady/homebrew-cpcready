class Cpcready < Formula
  version "0.1.0"
  desc "CPCReady SDK"
  homepage "https://github.com/CPCReady/software"
  url "https://github.com/CPCReady/software/releases/download/#{version}/CPCReady-#{version}.tar.gz"
  sha256 "6f1334396427dbb7c822a5e117bdafcdc4ca56e7dd07b47d7c281f759c0ca938"

  depends_on "dos2unix"
  depends_on "jq"
  depends_on "yq"

  def install
    # bin.install Dir["bin/*"]
    bin.install "bin/cpc-about.sh"
    bin.install "bin/cpc-cls.sh"
    bin.install "bin/cpc-amsdos.sh" => "amsdos"
    bin.install "bin/cpc-disc.sh"
    bin.install "bin/cpc-cat.sh"
    bin.install "bin/cpc-mode.sh"
    bin.install "bin/cpc-model.sh"
    bin.install "bin/cpc-new.sh"
    bin.install "bin/cpc-run.sh"
    bin.install "bin/cpc-save.sh"
    bin.install "bin/cpc-library.sh"
    share.install "share/VERSION"
    share.install "share/CPCReady.j2"
    share.install "share/DISC.j2"
    share.install "share/RetroVirtualMachine.j2"
    share.install "share/settings.j2"

    if OS.mac?
      bin.install "bin/osx/iDSK"
    end

    if OS.linux?
      bin.install "bin/linux/iDSK"
    end
  end

  test do
    # Verifica que los ejecutables se instalaron correctamente
    # assert_equal "1.0.1", shell_output("#{bin}/cpc-about.sh --version").strip
    # Verifica que el archivo 'VERSION' se puede leer desde el directorio 'share'
    assert_predicate share/"VERSION", :exist?
  end
end
