class Chattybara < Formula
  desc "Terminal radio chat client with the clean-room orca modem stack"
  homepage "https://github.com/nvk/chattybara"
  version "0.1.0-alpha.6"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/nvk/chattybara/releases/download/v0.1.0-alpha.6/chattybara-0.1.0-alpha.6-aarch64-apple-darwin.tar.gz"
    sha256 "7ad876c6b2ba974188204f457bc3fa0dacae0d20b6fed5b0452a773291d8f7c7"
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
