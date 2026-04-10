class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.12.0/databricks-claude-darwin-arm64"
      sha256 "d92aca0c3b58b77020fbe6f05064be48877c19d5e912020cbce136660c34cb04"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.12.0/databricks-claude-darwin-amd64"
      sha256 "ce069c86c692358ed34f53b4dddf374bca22d762daf40f171f7e6fb3103c168e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.12.0/databricks-claude-linux-arm64"
      sha256 "e53d18bd7bf3eb5ac28faeaed9019540ec18f246fe39c62f1391a44bd96d8e65"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.12.0/databricks-claude-linux-amd64"
      sha256 "25810711824bb595f0d63e274fbf1c3f4752afb7539dd83d2e0ba8ff8205428f"
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
