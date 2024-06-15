class Cpcready < Formula
  desc "Command-line interface (CLI) for programming Amstrad CPC in Visual Studio Code"
  homepage "https://github.com/CPCReady/software"
  url "https://github.com/CPCReady/software/releases/download/0.1.1/CPCReady-0.1.1.tar.gz"
  sha256 "2008993f28e34b0749b7fdb44698f5b1c719562f5becd6d5d9f5631085f57332"
  license "MIT"

  depends_on "dos2unix"
  depends_on "jq"
  depends_on "yq"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # Ajusta la siguiente línea según la estructura real del tarball
    # Si bin/IDSK-PLUS no existe, elimina o actualiza esta sección
    if File.directory?("bin/IDSK-PLUS")
      cd "bin/IDSK-PLUS" do
        system "make"
      end
    end

    # Instalar scripts y binarios
    bin.install "bin/cpc-about.sh"
    bin.install "bin/cpc"
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
    
    # Instalar plantillas y archivos de configuración
    share.install "share/VERSION"
    share.install "share/CPCReady.j2"
    share.install "share/DISC.j2"
    share.install "share/RetroVirtualMachine.j2"
    share.install "share/settings.j2"

    # Instalar iDSK dependiendo del SO
    bin.install "bin/osx/iDSK" if OS.mac?
    bin.install "bin/linux/iDSK" if OS.linux?
  end

  test do
    # Verificar que el archivo 'VERSION' existe
    assert_predicate share/"VERSION", :exist?
  end
end
