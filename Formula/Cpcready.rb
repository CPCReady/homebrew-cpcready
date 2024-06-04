class Cpcready < Formula
  include Language::Python::Virtualenv
  version "1.0.0"
  desc "CPCReady SDK"
  homepage "https://github.com/CPCReady/sdk"
  url "https://github.com/CPCReady/sdk/releases/download/#{version}/CPCReady-#{version}.tar.gz"
  sha256 "6f1334396427dbb7c822a5e117bdafcdc4ca56e7dd07b47d7c281f759c0ca938"

  resource "amsdospy" do
    url "https://github.com/CPCReady/amsdospy/releases/download/1.0.0/amsdospy-1.0.0.tar.gz"
    sha256 "ca030112241dbd03f26c8e56a6a12f624634bee906ce85f5aa5f459685a78f65" 
  end

  resource "cpcemu_mac" do
    url "https://cpc-emu.org/Release/2022-08-13/CPCemuMacOS.app-2.5.zip"
    sha256 "794d815c13c66c212fb9dbe627e6bffd723d4a83c04ca786fd728406a8e7bf1d" 
  end
  resource "rvm_mac" do
    url "https://static.retrovm.org/release/beta1/macos/RetroVirtualMachine.2.0.beta-1.r7.macos.dmg"
    sha256 "75e94f2df589ead3fb1eab529713312a17dc16e6b2ba547594cd9d5975def566" 
  end

  resource "prompt-toolkit" do
    url "https://files.pythonhosted.org/packages/66/10/60dfbae0c000879066656fc15bb8d0d1d4235ead415959defcbeb57ee060/prompt_toolkit-3.0.45.tar.gz"
    sha256 "07c60ee4ab7b7e90824b61afa840c8f5aad2d46b3e2e10acc33d8ecc94a49089"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/6c/63/53559446a878410fc5a5974feb13d31d78d752eb18aeba59c7fef1af7598/wcwidth-0.2.13.tar.gz"
    sha256 "72ea0c06399eb286d978fdedb6923a9eb47e1c486ce63e9b4e64fc18303972b5"
  end

  resource "configparser" do
    url "https://files.pythonhosted.org/packages/fd/1d/a0f55c373f80437607b898956518443b9edd435b5a226392a9ef11d79fa0/configparser-7.0.0.tar.gz"
    sha256 "af3c618a67aaaedc4d689fd7317d238f566b9aa03cae50102e92d7f0dfe78ba0"
  end

  resource "python-dotenv" do
    url "https://files.pythonhosted.org/packages/bc/57/e84d88dfe0aec03b7a2d4327012c1627ab5f03652216c63d49846d7a6c58/python-dotenv-1.0.1.tar.gz"
    sha256 "e324ee90a023d808f1959c46bcbc04446a10ced277783dc6ee09987c37ec10ca"
  end

  depends_on "dos2unix"
  depends_on "jq"
  depends_on "python@3.12"

  def install
    bin.install "bin/about", "bin/cls", "bin/amsdos", "bin/disc", "bin/emulator", "bin/lcat", "bin/mode", "bin/model", "bin/new", "bin/run", "bin/save"
    # bin.install Dir["bin/*"]
    share.install "share/VERSION"
    lib.install "lib/cpcLib.sh"

    if OS.mac?
      bin.install "bin/cat2cpc/dist/cat2cpc-osx-universal" => "cat2cpc"
      bin.install "bin/cpc-config/dist/cpc-config-osx-universal" => "cpc-config"
      bin.install "bin/iDSK+/bin/iDSK-osx-universal" => "iDSK"

      # # bin.install "Emuladores/CPCemuMacOS.app"
      # resource("cpcemu_mac").stage do
      #   (bin/"CPCemuMacOS.app").install Dir["*"]
      # end
      home_cpc_ready = Pathname.new(Dir.home).join(".pepepe")
      home_cpc_ready.mkpath

  
      # Copiar un archivo específico a la carpeta creada en el home del usuario
      (home_cpc_ready).install "share/VERSION"
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
