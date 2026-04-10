class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.8.0/databricks-codex-darwin-arm64"
      sha256 "938e5f5ce67dfb7ce030eb68f3472abace9aafa2228bf717410cb3e2feda93ba"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.8.0/databricks-codex-darwin-amd64"
      sha256 "2ce632e06943ad475142367668823cc4de76fb436a18c07e389955a1f1f50ccd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.8.0/databricks-codex-linux-arm64"
      sha256 "1bd7e3a9da1decb4e9c8bd69a6f091bfe7635f30b62b3a31a17a763561d3d904"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.8.0/databricks-codex-linux-amd64"
      sha256 "c3f7742d511e01f80ab234fd8efa4e7f5a4ba2b70ea0e27858aa95cada2bd36c"
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
