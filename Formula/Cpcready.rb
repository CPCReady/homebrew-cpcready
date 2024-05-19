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

class Cpcready < Formula
    desc "CPCReady SDK"
    homepage "https://github.com/CPCReady/sdk"
    # version "1.0.1"
    url "https://github.com/CPCReady/sdk/releases/download/v1.0.1/CPCReady.tar.gz"
    sha256 "7e006dd18d7e987a2959f0c21546b6208c312a2f56c20086bfc3ccc3332aa553"
  
    def install
      # Crear el directorio /opt/CPCReady si no existe
      # uses_from_macos "jq"
      # uses_from_macos "dos2unix"
      # opt_prefix = Pathname.new("$HOME/CPCReady")
      # opt_prefix.mkpath
  
      # # Copiar todos los archivos al directorio /opt/CPCReady
      # opt_prefix.install Dir["*"]
  
      # # Crear enlaces simbólicos en /usr/local/bin para cada ejecutable en /opt/CPCReady/bin
      # (opt_prefix/"bin").each_child do |executable|
      #   bin.install_symlink executable
      # end
    end
  
    test do
      # Comprobar que el software se instaló correctamente y puede ejecutarse
      assert_predicate "/opt/CPCReady/bin/about", :exist?
      assert_match "expected_output", shell_output("#{bin}/about --version")
    end
  end
  