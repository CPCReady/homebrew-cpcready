class Idsk < Formula
  desc "Amstrad CPC Disk Image Management Tool - Professional CLI utility for DSK files"
  homepage "https://github.com/CPCReady/idsk"
  url "https://github.com/CPCReady/idsk/archive/refs/tags/v0.23.tar.gz"
  sha256 "304a45ee7083ea108c10b291cd2b658f8a9d389cec3a702c0ef343c640ede5f5"
  license "MIT"

  # Bottles para múltiples plataformas
  bottle do
    root_url "https://github.com/CPCReady/idsk/releases/download/v0.23"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4f501ef378078a69f185a6684d7940b575ef0a9f8bdaeaaf3f443708294bb524"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4f501ef378078a69f185a6684d7940b575ef0a9f8bdaeaaf3f443708294bb524"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "4f501ef378078a69f185a6684d7940b575ef0a9f8bdaeaaf3f443708294bb524"
    sha256 cellar: :any_skip_relocation, sequoia:       "dc9fb2cb525148215f9627136b5e8fef806303f5f2c589a30c3836e9063fbac6"
    sha256 cellar: :any_skip_relocation, sonoma:        "dc9fb2cb525148215f9627136b5e8fef806303f5f2c589a30c3836e9063fbac6"
    sha256 cellar: :any_skip_relocation, ventura:       "dc9fb2cb525148215f9627136b5e8fef806303f5f2c589a30c3836e9063fbac6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e72838f9c962bf86137941c4697585008ba7fea0d2e85eb751c3694c1846bf18"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "69813fa8067c4e1ecd0be47507e85c646f76a14d1f533a7ccb76967f8fde0e81"
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
