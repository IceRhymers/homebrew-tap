class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.10.0/databricks-codex-darwin-arm64"
      sha256 "1e125deaae1f75842e9b8187ff26d8f00372e77eb1240c63e2f09d9c24b6b012"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.10.0/databricks-codex-darwin-amd64"
      sha256 "faf0a6fa5e3d1b06cf508b92476fd03ad1bab9b245d73383d2e1596ad9546ee5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.10.0/databricks-codex-linux-arm64"
      sha256 "41cd7a2778365996938995e689ce2660288f896a6a5f556e38b83d67d5804b72"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.10.0/databricks-codex-linux-amd64"
      sha256 "3a509837e9ff9d56116c03fbc94bf9600a212a9904a616c53d40b6459a007e7a"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    binary = "databricks-codex-#{os}-#{arch}"
    chmod "+x", binary
    bin.install binary => "databricks-codex"
    generate_completions_from_executable(bin/"databricks-codex", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-codex --version 2>&1")
    assert_match "databricks-codex", shell_output("#{bin}/databricks-codex completion bash")
    assert_match "databricks-codex", shell_output("#{bin}/databricks-codex completion zsh")
    assert_match "databricks-codex", shell_output("#{bin}/databricks-codex completion fish")
  end
end
