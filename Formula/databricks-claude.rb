class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.12.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.12.1/databricks-claude-darwin-arm64"
      sha256 "74a627ef22bcc318419a9388426bc1afb62e4e7976b47b081a9393840bb57440"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.12.1/databricks-claude-darwin-amd64"
      sha256 "792bbe9e02459cd42d9474048248b10e2e97921159911d210abfdf44132b96b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.12.1/databricks-claude-linux-arm64"
      sha256 "cd88155b8912e47f573098e9d6a8ca6f29ea9d076b3580fe3d21219b02bc083e"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.12.1/databricks-claude-linux-amd64"
      sha256 "5cade2dd30f9334f3dbb6c6d4128cc0e5cb1587cfbc040dd49188447083e1256"
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
