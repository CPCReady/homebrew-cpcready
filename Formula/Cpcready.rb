class Cpcready < Formula
  desc "CPCReady SDK"
  homepage "https://github.com/CPCReady/sdk"
  url "https://github.com/CPCReady/sdk/releases/download/v1.0.1/CPCReady.tar.gz"
  sha256 "e44c37d8abed807033aa6be12456428608c78c29279eb21fd5846b83f3ab545e"

  depends_on "dos2unix"
  depends_on "jq"

  def install
    # Instala los archivos binarios en el directorio 'bin'
    # bin.install "bin/about", "bin/cls", "bin/configuration", "bin/console-amstrad", "bin/cpc", "bin/dir", "bin/disc", "bin/emulator", "bin/iDSK","bin/lcat", "bin/mode", "bin/new", "bin/run", "bin/save"
    bin.install Dir["bin/*"]
    share.install "share/VERSION"
    lib.install "lib/library.sh"
    # Instala solo en oscx
    if OS.mac?
      bin.mkpath
      # mkdir_p share/"CPCReady"
      # mv "share/rvm.app", share/"CPCReady/rvm.app"
      # mv "share/CPCemuMacOS.app", share/"CPCReady/CPCemuMacOS.app"
      install_dir = File.expand_path("~/CPCReady")

      # Crea la carpeta si no existe
      mkdir_p install_dir
      mv "share/rvm.app", "~/CPCReady/rvm.app"
      mv "share/CPCemuMacOS.app", "~/CPCReady/CPCemuMacOS.app"
    end

    # Instala cpcemu solo en Linux
    if OS.linux?
      lib.install "share/cpcemu"
    end
  end

  test do
    # Verifica que los ejecutables se instalaron correctamente
    assert_equal "1.0.1", shell_output("#{bin}/about --version").strip
    # Verifica que el archivo 'VERSION' se puede leer desde el directorio 'share'
    assert_predicate share/"VERSION", :exist?
  end
end

  # resource "python_wheel" do
  #   url "https://example.com/python_wheel.whl"
  #   sha256 "sha256-del-archivo.whl"
  # end

    # # Verifica si la versión de Python es 3.10 o superior
    # python_version = Utils.safe_popen_read("python3", "--version").chomp
    # if python_version.start_with?("Python 3.10", "Python 3.11")
    #   # Instala el archivo Wheel de Python en el directorio 'libexec'
    #   libexec.install resource("python_wheel")
    #   # Instala el archivo Wheel en el entorno del sistema
    #   system "python3", "-m", "pip", "install", libexec/"python_wheel.whl"
    # else
    #   opoo "Python 3.10 or newer is required to install this package. Skipping installation of Python Wheel."
    # end


# class Cpcready < Formula
#     desc "My CPCReady software"
#     homepage "https://github.com/CPCReady/sdk"
#     version "1.0.0"
#     url "https://github.com/CPCReady/sdk/releases/download/v1.0.1/CPCReady.tar.gz"
#     sha256 "7e006dd18d7e987a2959f0c21546b6208c312a2f56c20086bfc3ccc3332aa553"
  
#     def install
#       # Crear el directorio /opt/CPCReady
#       opt_prefix = "/opt/CPCReady"
#       (opt_prefix).install Dir["*"]
  
#       # Crear enlaces simbólicos en /usr/local/bin para cada ejecutable en /opt/CPCReady/bin
#       bin.install_symlink Dir["#{opt_prefix}/bin/*"]
#     end
  
#     test do
#       # Comprobar que el software se instaló correctamente y puede ejecutarse
#       assert_predicate opt_prefix/"bin/about", :exist?
#       assert_match "expected_output", shell_output("#{bin}/about --version")
#     end
#   end

# class Cpcready < Formula
#     desc "CPCReady SDK"
#     homepage "https://github.com/CPCReady/sdk"
#     # version "1.0.1"
#     url "https://github.com/CPCReady/sdk/releases/download/v1.0.1/CPCReady.tar.gz"
#     sha256 "9744e959095cb4fb329109eab67000ca73d4040c914017953e73376153fceb1b"
  
#     def install
#       # Crear el directorio /opt/CPCReady si no existe

#       # bash_shellenv.install <<-SHELL
#       # export SDKMAN_DIR="$HOME/.sdkman"
#       # . "$HOME/.sdkman/bin/sdkman-init.sh"
#       # SHELL
#       # zsh_shellenv.install <<-SHELL
#       #     export SDKMAN_DIR="$HOME/.sdkman"
#       #     . "$HOME/.sdkman/bin/sdkman-init.sh"
#       # SHELL
#       # on_linux do
#       #   depends_on "util-linux"
#       # end
#     #   install_dir = File.expand_path("~/CPCReady")

#     #   # Crea la carpeta si no existe
#     #   mkdir_p install_dir
  
#     #   # Copia todos los archivos a la carpeta de instalación
#     # # Copia todos los archivos a la carpeta de instalación
#     #   cp_r Dir["*"], install_dir
#             # uses_from_macos "jq"
#       # uses_from_macos "dos2unix"
#       # opt_prefix = Pathname.new("$HOME/CPCReady")
#       # opt_prefix.mkpath
#       bin.install "cls"
#       bin.install "console"
#       bin.install "about"
#       bin.install "configuration"
#       share.install "cpc"
#       # # Copiar todos los archivos al directorio /opt/CPCReady
#       # opt_prefix.install Dir["*"]
  
#       # # Crear enlaces simbólicos en /usr/local/bin para cada ejecutable en /opt/CPCReady/bin
#       # (opt_prefix/"bin").each_child do |executable|
#       #   bin.install_symlink executable
#       # end
#       # bin.install_symlink Dir["#{install_dir}/bin/*"]
#     end
  
#     test do
#       # Comprobar que el software se instaló correctamente y puede ejecutarse
#       system "#{bin}/about", "--version"
#       # assert_predicate "/opt/CPCReady/bin/about", :exist?
#       # assert_match "expected_output", shell_output("#{bin}/about --version")
#     end
#   end
  