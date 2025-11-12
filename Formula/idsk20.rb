class Idsk < Formula
  desc "Amstrad CPC Disk Image Management Tool - Professional CLI utility for DSK files"
  homepage "https://github.com/CPCReady/idsk20"
  url "https://github.com/CPCReady/idsk20/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "59a9a6049f9cbae79c6988073bd68678735a568962460ce31af6ae3fe4997aae"
  license "MIT"

  # Bottles para múltiples plataformas
  bottle do
    root_url "https://github.com/CPCReady/idsk20/releases/download/v2.0.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0f219590363bdf6c0f3702ea058c38f234dd2bce01cfc2017d808b176b36628e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0f219590363bdf6c0f3702ea058c38f234dd2bce01cfc2017d808b176b36628e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0f219590363bdf6c0f3702ea058c38f234dd2bce01cfc2017d808b176b36628e"
    sha256 cellar: :any_skip_relocation, sequoia:       "10a941ef23e334380a3f225117d86258b52cb0d320b71d27c6492fb58d4025d7"
    sha256 cellar: :any_skip_relocation, sonoma:        "10a941ef23e334380a3f225117d86258b52cb0d320b71d27c6492fb58d4025d7"
    sha256 cellar: :any_skip_relocation, ventura:       "10a941ef23e334380a3f225117d86258b52cb0d320b71d27c6492fb58d4025d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d95a70c69ab3c901301028387d00dc3de6e649fd08755c5cb2a0e9f7f0875b0"
    sha256 cellar: :any_skip_relocation, aarch64_linux: "eb16cee1f07df3538a5c18dc1bb8244066e7fa2f4ce1b363efd6b820664e6aa1"
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
