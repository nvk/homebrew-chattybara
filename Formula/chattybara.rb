class Chattybara < Formula
  desc "Terminal radio chat client with the clean-room orca modem stack"
  homepage "https://github.com/nvk/chattybara"
  version "0.1.0-alpha.2"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/nvk/chattybara/releases/download/v0.1.0-alpha.2/chattybara-0.1.0-alpha.2-aarch64-apple-darwin.tar.gz"
    sha256 "efd1ca9cd28ad170a1957a2bce0d43574c297ee6717fe5339e622ffa9b86f615"
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
  end
end
