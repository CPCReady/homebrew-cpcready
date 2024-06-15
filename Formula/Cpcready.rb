class Cpcready < Formula
  desc "Command-line interface (CLI) for programming Amstrad CPC in Visual Studio Code"
  homepage "https://github.com/CPCReady/software"
  url "https://github.com/CPCReady/software/releases/download/0.1.2/CPCReady-0.1.2.tar.gz"
  sha256 "f0b8fd74e3f45676773b7bdc11234f02f430c583f9d590c7232e444d6fcbe0bd"
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
    cd "IDSK-PLUS" do
        system "mkdir","bin"
        system "make","clean"
        system "make"
    end


    # Instalar scripts y binarios
    bin.install "IDSK-PLUS/bin/iDSK"
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
