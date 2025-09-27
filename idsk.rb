class Idsk < Formula
  desc "A tool to do something with IDs"
  homepage "https://github.com/CPCReady/iDSK-CPCReady"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/CPCReady/idsk/releases/download/v1.0.0/iDSK-mac-arm64.zip"
      sha256 "80c7d18b8537ca60a769753499fe415b19ffab23459eba432233aa8558e7305d"
    elsif Hardware::CPU.intel?
      url "https://github.com/CPCReady/idsk/releases/download/v1.0.0/iDSK-mac-x86_64.zip"
      sha256 "f69c5bed89576d98ba6e5d327efe12be3afa4e10f7d0dc719fe376d22adecf70"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/CPCReady/iDSK-CPCReady/releases/download/v1.0.0/iDSK-linux-amd64"
      sha256 "ec9c393a252158127a9d058617a5e5caf6da945968d7669644efa1b64ad99084"
    elsif Hardware::CPU.intel?
      url "https://github.com/CPCReady/iDSK-CPCReady/releases/download/v1.0.0/iDSK-linux-amd64"
      sha256 "ec9c393a252158127a9d058617a5e5caf6da945968d7669644efa1b64ad99084"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "iDSK-macos-arm64" => "idsk"
      elsif Hardware::CPU.intel?
        bin.install "iDSK-macos-amd64" => "idsk"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "iDSK-linux-arm64" => "idsk"
      elsif Hardware::CPU.intel?
        bin.install "iDSK-linux-amd64" => "idsk"
      end
    end
  end

  test do
    system "#{bin}/idsk", "--version"
  end
end
