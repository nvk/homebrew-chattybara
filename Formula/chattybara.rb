class Chattybara < Formula
  desc "Terminal radio chat client with the clean-room orca modem stack"
  homepage "https://github.com/nvk/chattybara"
  version "0.1.0-alpha.10"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/nvk/chattybara/releases/download/v0.1.0-alpha.10/chattybara-0.1.0-alpha.10-aarch64-apple-darwin.tar.gz"
    sha256 "eb7f363b064a25f4b6b935b5fcff31e6e0e4756066bb0d4fec83edcb232e4ab8"
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
    settings = testpath/"settings.toml"
    system "#{bin}/chattybara", "station", "config", "--station", "JA1TST", "--path", settings
    ENV["CHATTYBARA_SETTINGS"] = settings.to_s
    output = shell_output("#{bin}/chattybara winlink telnet --check")
    assert_match '"transport": "telnet-cms"', output
  end
end
