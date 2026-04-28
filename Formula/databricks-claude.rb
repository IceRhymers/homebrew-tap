class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.13.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.13.0/databricks-claude-darwin-arm64"
      sha256 "ceaf5ed9c7d7cbc1ccbe063311c1269acd069482414ac89d8213512f0220acd3"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.13.0/databricks-claude-darwin-amd64"
      sha256 "e47b5819805b6c5b767fdcd3fbbb5a904e44ec709801cd7dbff719f862205928"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.13.0/databricks-claude-linux-arm64"
      sha256 "6a5c4d48ec33b3b92148624b9d6e6cbe351c657c3364092db4a1810be2a7fbc0"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.13.0/databricks-claude-linux-amd64"
      sha256 "02c2b04d14209ec3a1af2645a26a55ae37269686321458dd128ccdb0c2b93119"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    binary = "databricks-claude-#{os}-#{arch}"
    chmod "+x", binary
    bin.install binary => "databricks-claude"
    generate_completions_from_executable(bin/"databricks-claude", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-claude --version 2>&1")
    assert_match "databricks-claude", shell_output("#{bin}/databricks-claude completion bash")
    assert_match "databricks-claude", shell_output("#{bin}/databricks-claude completion zsh")
    assert_match "databricks-claude", shell_output("#{bin}/databricks-claude completion fish")
  end
end
