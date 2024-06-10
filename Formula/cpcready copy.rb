class Cpcready < Formula
  include Language::Python::Virtualenv
  version "1.0.0"
  desc "CPCReady SDK"
  homepage "https://github.com/CPCReady/sdk"
  url "https://github.com/CPCReady/sdk/releases/download/#{version}/CPCReady-#{version}.tar.gz"
  sha256 "6f1334396427dbb7c822a5e117bdafcdc4ca56e7dd07b47d7c281f759c0ca938"

  depends_on "dos2unix"
  depends_on "jq"
  depends_on "yq"

  def install
    bin.install "bin/cpc-about.sh"
    bin.install "bin/cpc-cls.sh"
    bin.install "bin/cpc-amsdos.sh"
    bin.install "bin/cpc-disc.sh"
    bin.install "bin/cpc-cat.sh"
    bin.install "bin/cpc-mode.sh"
    bin.install "bin/model"
    bin.install "bin/cpc-new.sh"
    bin.install "bin/cpc-run.sh"
    bin.install "bin/cpc-save.sh"
    # bin.install Dir["bin/*"]
    share.install "share/VERSION"
    lib.install "lib/cpcLib.sh"

    if OS.mac?
      bin.install "bin/cat2cpc/dist/cat2cpc-osx-universal" => "cat2cpc"
      bin.install "bin/cpc-config/dist/cpc-config-osx-universal" => "cpc-config"
      bin.install "bin/iDSK+/bin/iDSK-osx-universal" => "iDSK"
      home_directory = Dir.home

      # Concatena la ruta absoluta con la ruta del directorio que deseas crear
      directory_path = File.join(home_directory, ".CPCReady")
      
      # Crea el directorio utilizando la ruta absoluta
      system "mkdir", "-p", "$HOME/asdfasdf"
      # # bin.install "Emuladores/CPCemuMacOS.app"
      # resource("cpcemu_mac").stage do
      #   (bin/"CPCemuMacOS.app").install Dir["*"]
      # end
      # home_cpc_ready = Pathname.new(Dir.home).join(".pepepe")
      # home_cpc_ready.mkpath

  
      # Copiar un archivo específico a la carpeta creada en el home del usuario
      # (home_cpc_ready).install "share/VERSION"
    end

    if OS.linux?
      bin.install "bin/cat2cpc/bin/cat2cpc-linux-x86_64" => "cat2cpc"
      bin.install "bin/cpc-config/bin/cpc-config-linux-x86_64" => "cpc-config"
      bin.install "bin/iDSK+/bin/iDSK-ubuntu-latest/iDSK" => "iDSK"
      bin.install "Emuladores/cpcemu"
      bin.install "Emuladores/RetroVirtualMachine"
    end

    # Instala el módulo Python amsdospy
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install resource("configparser")
    venv.pip_install resource("prompt-toolkit")
    venv.pip_install resource("wcwidth")
    venv.pip_install resource("python-dotenv")
    venv.pip_install resource("amsdospy")
    bin.install_symlink libexec/"bin/amsdospy"

    bin.children.each { |file| chmod 0777, file }
  end

  # post_install do
  #   # Crear una carpeta en el home del usuario
  #   home_cpc_ready = Pathname.new(Dir.home).join(".CPCReady")
  #   home_cpc_ready.mkpath

  #   # Copiar un archivo específico a la carpeta creada en el home del usuario
  #   (home_cpc_ready/"your_file").write <<~EOS
  #     contenido del archivo que quieras escribir o un comando para copiar un archivo
  #   EOS
  # end
  test do
    # Verifica que los ejecutables se instalaron correctamente
    assert_equal "1.0.1", shell_output("#{bin}/about --version").strip
    # Verifica que el archivo 'VERSION' se puede leer desde el directorio 'share'
    assert_predicate share/"VERSION", :exist?
  end
end
