class Cpcready < Formula
  include Language::Python::Virtualenv
  version "1.0.0"
  desc "CPCReady SDK"
  homepage "https://github.com/CPCReady/sdk"
  url "https://github.com/CPCReady/sdk/releases/download/#{version}/CPCReady-#{version}.tar.gz"
  sha256 "6e7d471c69c6b57042c1d70fb551f3a68f5570a62629a94210355927f735db02"

  resource "cpcemu_mac" do
    url "https://cpc-emu.org/Release/2022-08-13/CPCemuMacOS.app-2.5.zip"
    sha256 "794d815c13c66c212fb9dbe627e6bffd723d4a83c04ca786fd728406a8e7bf1d" 
  end
  resource "rvm_mac" do
    url "https://static.retrovm.org/release/beta1/macos/RetroVirtualMachine.2.0.beta-1.r7.macos.dmg"
    sha256 "75e94f2df589ead3fb1eab529713312a17dc16e6b2ba547594cd9d5975def566" 
  end
  resource "cpcemu_linux" do
    url "https://cpc-emu.org/Release/2022-08-13/cpcemu-linux-x86_64-2.5.tar.gz"
    sha256 "5d8d2cb53f4fbc95f607787fdb417b074c04fe04600f0107829798f4234d9f1c" 
  end
  resource "rvm_linux" do
    url "https://static.retrovm.org/release/beta1/linux/x64/RetroVirtualMachine.2.0.beta-1.r7.linux.x64.zip"
    sha256 "7ac5f0c5e668088869ef2a229b22051714ef4a3b108b263e40298f8a3e27aad5" 
  end

  resource "amsdospy" do
    url "https://github.com/CPCReady/amsdospy/releases/download/1.0.0/amsdospy-1.0.0.tar.gz"
    sha256 "aabe560fb5e54f7890c657877c461c4dde473073a7fc06a271a339a5d3167a82" 
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
      bin.install "bin/cat2cpc/bin/cat2cpc-osx-universal" => "cat2cpc"
      bin.install "bin/cpc-config/bin/cpc-config-osx-universal" => "cpc-config"
      bin.install "bin/iDSK+/bin/iDSK-macos-latest/iDSK" => "iDSK"
      share.install "Emuladores/RetroVirtualMachine2.app"
      resource("cpcemu_mac").stage do
        (share/"CPCemuMacOS.app").install Dir["*"]
      end
    end

    if OS.linux?
      bin.install "bin/cat2cpc/bin/cat2cpc-linux-x86_64" => "cat2cpc"
      bin.install "bin/cpc-config/bin/cpc-config-linux-x86_64" => "cpc-config"
      bin.install "bin/iDSK+/bin/iDSK-ubuntu-latest/iDSK" => "iDSK"

      resource("cpcemu_linux").stage do
        (share/"cpcemu").install Dir["*"]
      end

      resource("rvm_linux").stage do
        (share).install Dir["*"]
      end
    end

    # Instala el módulo Python amsdospy
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install resource("amsdospy")
    bin.install_symlink libexec/"bin/amsdospy"

    bin.children.each { |file| chmod 0777, file }
  end

  test do
    # Verifica que los ejecutables se instalaron correctamente
    assert_equal "1.0.1", shell_output("#{bin}/about --version").strip
    # Verifica que el archivo 'VERSION' se puede leer desde el directorio 'share'
    assert_predicate share/"VERSION", :exist?
  end
end
