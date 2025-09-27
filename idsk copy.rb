class Idsk < Formula
  desc "A tool to do something with IDs"
  homepage "https://github.com/CPCReady/iDSK-CPCReady"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/CPCReady/iDSK-CPCReady/releases/download/v1.0.0/iDSK-macos-amd64"
      sha256 "ad51b0560d56442b972d8b00ed856f3647ba9f06976999b1ecdd00e1c2b9fdb3"
    elsif Hardware::CPU.intel?
      url "https://github.com/CPCReady/iDSK-CPCReady/releases/download/v1.0.0/iDSK-macos-amd64"
      sha256 "ad51b0560d56442b972d8b00ed856f3647ba9f06976999b1ecdd00e1c2b9fdb3"
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
    bin.install "idsk"
  end

  test do
    system "#{bin}/idsk", "--version"
  end
end
