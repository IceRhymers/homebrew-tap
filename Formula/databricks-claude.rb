class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-agents"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-agents/releases/download/v1.2.0/databricks-claude-darwin-arm64"
      sha256 "732a4c47d0dc0ae34b2e13b7221e273c4c8339b311317ccb7877673a6dc267c5"
    else
      url "https://github.com/IceRhymers/databricks-agents/releases/download/v1.2.0/databricks-claude-darwin-amd64"
      sha256 "c519c2a69bc7882a9bdf1c02f2db4a118cd23f38f5ec39acce0e14ac4424a8dd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-agents/releases/download/v1.2.0/databricks-claude-linux-arm64"
      sha256 "049b554b9332790141957500bf9aec989f7fea4b507e2c6e502dbefc28e2cfbb"
    else
      url "https://github.com/IceRhymers/databricks-agents/releases/download/v1.2.0/databricks-claude-linux-amd64"
      sha256 "c4811e0e361528b0b95293eb0c75babd6b9864d626f39090ad37a95026677904"
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
