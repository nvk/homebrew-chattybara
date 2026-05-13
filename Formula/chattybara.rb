class Chattybara < Formula
  desc "Terminal radio chat client with the clean-room orca modem stack"
  homepage "https://github.com/nvk/chattybara"
  version "0.1.0-alpha.5"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/nvk/chattybara/releases/download/v0.1.0-alpha.5/chattybara-0.1.0-alpha.5-aarch64-apple-darwin.tar.gz"
    sha256 "684c13165f7e51a59bdc04cb4643daf80c013e69e0fd9e763bd493209f1a01b0"
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
