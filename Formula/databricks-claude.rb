class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.11.0/databricks-claude-darwin-arm64"
      sha256 "48497c3aa35f32d7a21cc87aa371bbe7cc41f88fb96259dd16ca1846803325d7"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.11.0/databricks-claude-darwin-amd64"
      sha256 "dc73ad579a62b37cc0b9db4cc9c16e9e2e9c0e6a959ffa3bb3fc3e385f73dda3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.11.0/databricks-claude-linux-arm64"
      sha256 "aca3e2061659bca4349ca066801930de37263a3faf4cc4df3e3b4e06f2dcf733"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.11.0/databricks-claude-linux-amd64"
      sha256 "a3a9762387db7fcf5fadb8cec3a558621ddba197520c0c56158847d43d166f67"
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
