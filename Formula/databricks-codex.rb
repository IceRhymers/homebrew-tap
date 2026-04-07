class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.6.0/databricks-codex-darwin-arm64"
      sha256 "5a3c7f6c65261a27828eb1f2a4c015fc63e279fefe5142b22599c9e164fc7d1e"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.6.0/databricks-codex-darwin-amd64"
      sha256 "66509f2e211370a935debc8ab0cd2689c265700d09c8b742ee776001f44f6579"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.6.0/databricks-codex-linux-arm64"
      sha256 "0fbae239eba434f5ba3774e18f4e11fe39018bed0e467711f37478bf3a7a9283"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.6.0/databricks-codex-linux-amd64"
      sha256 "224ac33491e5facc801ed2f814ee7c7c002a0d799094e48541174974e8c978e4"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "databricks-codex-#{os}-#{arch}" => "databricks-codex"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-codex --version 2>&1")
  end
end
