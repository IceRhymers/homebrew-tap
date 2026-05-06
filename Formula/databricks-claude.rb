class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.17.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.17.0/databricks-claude-darwin-arm64"
      sha256 "adbbb20e9863a49f8482402b52f745273cc5c98aa6f01ab2158f286aed57f70c"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.17.0/databricks-claude-darwin-amd64"
      sha256 "74be1c91fa036d02665313b6f870f6d1562c20d9c86c58f2e7360ea1dd732542"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.17.0/databricks-claude-linux-arm64"
      sha256 "c9aa692454f1f6106298fb864a4145463ccf8bbb4f6f06876857a7ccd4cc5396"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.17.0/databricks-claude-linux-amd64"
      sha256 "a032384a1a676fa4d01d249f11020dc07452cfe78c618b9e7b6dc0621e666d60"
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
