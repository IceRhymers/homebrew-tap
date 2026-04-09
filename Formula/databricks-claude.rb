class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.10.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.10.1/databricks-claude-darwin-arm64"
      sha256 "432ec7a19cb175bfdff3b2700a20255235150ec409738aa9715ed28899af1df8"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.10.1/databricks-claude-darwin-amd64"
      sha256 "3ca99ef5865a14150206debe2319f0dd29104f0ecfff040505188ddba504d5f9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.10.1/databricks-claude-linux-arm64"
      sha256 "d99ad725a53d4f60fea27d27fd32e5185e8371f2e331aad97331740fc972f14c"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.10.1/databricks-claude-linux-amd64"
      sha256 "a14c846006ff7e5adb24d4cd4e4f0574ae11bd7bfc1b96c239f0f9666b086aa4"
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
