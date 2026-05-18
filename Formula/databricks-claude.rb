class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.0/databricks-claude-darwin-arm64"
      sha256 "f75203fa5463ebc75cdc73fd00b55cbdd16998a0a770adc5d309fa75d504bec3"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.0/databricks-claude-darwin-amd64"
      sha256 "76cbe23f375f0ace6b2a048c6a989c18b3a588adb444a9417a702b5b43243d81"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.0/databricks-claude-linux-arm64"
      sha256 "d2eaa7ba884d17493fae0928acbb650a092e2d528224cc67037e749d75035757"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.0/databricks-claude-linux-amd64"
      sha256 "ef08e539d3ab96baa1642bd0a7a25c9a7aac7476415793fee2d5d86257f2719e"
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
