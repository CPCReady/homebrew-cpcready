class Idsk < Formula
  desc "Amstrad CPC Disk Image Management Tool - Professional CLI utility for DSK files"
  homepage "https://github.com/CPCReady/idsk"
  url "https://github.com/CPCReady/idsk/archive/refs/tags/v0.24.tar.gz"
  sha256 "79df1f64147468f7932c501ef3b4e64d7ab9ecebf59c06b3e3ea33ee554eabdc"
  license "MIT"

  # Bottles para múltiples plataformas
  bottle do
    root_url "https://github.com/CPCReady/idsk/releases/download/v0.24"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d7683663e4c3f06c9e10c19f30601e65a989a6d98e9de0d304fedb308739c87d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d7683663e4c3f06c9e10c19f30601e65a989a6d98e9de0d304fedb308739c87d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d7683663e4c3f06c9e10c19f30601e65a989a6d98e9de0d304fedb308739c87d"
    sha256 cellar: :any_skip_relocation, sequoia:       "b582504fafad266eace7cf3c3518e2ac722e9fec79390d98f85e0767b5189b84"
    sha256 cellar: :any_skip_relocation, sonoma:        "b582504fafad266eace7cf3c3518e2ac722e9fec79390d98f85e0767b5189b84"
    sha256 cellar: :any_skip_relocation, ventura:       "b582504fafad266eace7cf3c3518e2ac722e9fec79390d98f85e0767b5189b84"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5fecc41efce6df3aa85182802362141f4aef6a1f55c1b58d10e4153739c78200"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "984832d8e5ff86e6f6667e47eb378ba18ab1aecf2231e8f432fbf4d34037afa6"
  end

  depends_on "cmake" => :build

  def install
    # Si estamos usando un bottle, el binario ya está en la ubicación correcta
    # Si estamos compilando desde fuente, necesitamos compilar
    if build.bottle?
      # Para bottles, simplemente copiar desde la estructura del bottle
      bin.install "bin/idsk" => "iDSK"
    else
      # Para compilación desde fuente
      system "cmake", "-S", ".", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
      system "cmake", "--build", "build", "--config", "Release"
      bin.install "build/iDSK"
    end

    # Instalar documentación si está disponible
    doc.install "README.md" if File.exist?("README.md")
    doc.install "AUTHORS" if File.exist?("AUTHORS")
    doc.install "docs/" if File.exist?("docs/BUILD.md")
  end

  test do
    # Crear un archivo DSK de prueba y verificar las funcionalidades básicas
    # Verificar que el comando existe y muestra ayuda
    output = shell_output("#{bin}/idsk 2>&1")
    assert_match "Enhanced version", output
    assert_match "Usage", output
    assert_match "OPTIONS", output

    # Verificar que podemos crear un nuevo DSK
    system bin/"idsk", "test.dsk", "-n"
    assert_path_exists testpath/"test.dsk"
  end
end
