class Chattybara < Formula
  desc "Terminal radio chat client with the clean-room orca modem stack"
  homepage "https://github.com/nvk/chattybara"
  version "0.1.0-alpha.3"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/nvk/chattybara/releases/download/v0.1.0-alpha.3/chattybara-0.1.0-alpha.3-aarch64-apple-darwin.tar.gz"
    sha256 "1ee233343baac746c275fc971866f4bc1e1009d5cafd07dd089dc6be2ffc54a0"
  else
    raise "prebuilt chattybara Homebrew formula currently supports Apple Silicon macOS only"
  end

  def install
    bin.install "chattybara"
  end

  test do
    system "#{bin}/chattybara", "--help"
    output = shell_output("#{bin}/chattybara modem roundtrip \"hello chattybara\"")
    assert_match '"ok": true', output
    output = shell_output("#{bin}/chattybara winlink telnet --station JA1TST --check")
    assert_match '"transport": "telnet-cms"', output
  end
end
