class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.10.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.10.0/databricks-claude-darwin-arm64"
      sha256 "a7b0be144f69d399851e20fa7f0cf9bc837138bc31e1b1c67f503d9fddc8d10f"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.10.0/databricks-claude-darwin-amd64"
      sha256 "af1bf980a5a7e87bf11d7bc5927edebd0e4d658214e131094b6bb969d23970ee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.10.0/databricks-claude-linux-arm64"
      sha256 "4b9e1721f04728bbadb59dd463d5d033c2c030674ceebac2b67bf94327921af3"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.10.0/databricks-claude-linux-amd64"
      sha256 "0e249225514cbb8ae5bd47d1fc77d15c5d942c52d5876ba5b4ab70a477263f6e"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    binary = "databricks-claude-#{os}-#{arch}"
    chmod "+x", binary
    bin.install binary => "databricks-claude"
    generate_completions_from_executable(bin/"databricks-claude", "completion", shell_parameter_format: :arg)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-claude --version 2>&1")
    assert_match "databricks-claude", shell_output("#{bin}/databricks-claude completion bash")
    assert_match "databricks-claude", shell_output("#{bin}/databricks-claude completion zsh")
    assert_match "databricks-claude", shell_output("#{bin}/databricks-claude completion fish")
  end
end
