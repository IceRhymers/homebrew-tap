class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.1.0/databricks-claude-darwin-arm64"
      sha256 "0d8f6227f3b8b6dcf60b5a317d0d58b4b3046892e90581700837ae1b3d0ee35a"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.1.0/databricks-claude-darwin-amd64"
      sha256 "42cc0fc8b6e165bf6d405960dd8541d370e7853ddb3942edafcba95077b26dd8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.1.0/databricks-claude-linux-arm64"
      sha256 "aa8765e80d68b9762eb2fc5eb422679fc3b48bd9f1674242cf2d4f6d8ed88d7b"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.1.0/databricks-claude-linux-amd64"
      sha256 "1e86b36ac1a0a9df86e3ca456693c51363494f1627393a24e76c6e894c8316ed"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    binary = "databricks-claude-#{os}-#{arch}"
    chmod "+x", binary
    bin.install binary => "databricks-claude"
    # Claude Desktop's inferenceCredentialHelper config points at a binary
    # path with no arguments. The wrapper dispatches on argv[0]: invoking it
    # under this name routes directly to the credential-helper code path.
    bin.install_symlink "databricks-claude" => "databricks-claude-credential-helper"
    generate_completions_from_executable(bin/"databricks-claude", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-claude --version 2>&1")
    assert_match "databricks-claude", shell_output("#{bin}/databricks-claude completion bash")
    assert_match "databricks-claude", shell_output("#{bin}/databricks-claude completion zsh")
    assert_match "databricks-claude", shell_output("#{bin}/databricks-claude completion fish")
    assert_predicate bin/"databricks-claude-credential-helper", :symlink?
    assert_equal (bin/"databricks-claude").realpath,
                 (bin/"databricks-claude-credential-helper").realpath
  end
end
