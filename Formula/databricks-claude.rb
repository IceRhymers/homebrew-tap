class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.14.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.14.0/databricks-claude-darwin-arm64"
      sha256 "dbae3c504bff60040018035571d97f9517d702aa0dbcf1849f435284ccfb236e"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.14.0/databricks-claude-darwin-amd64"
      sha256 "a53d4b40b75245a8143665002c14cee7610b21770f4a1a64367eb24f4a0700e8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.14.0/databricks-claude-linux-arm64"
      sha256 "b2b7ca87058882acb658c5ed7e881be0e2924324202952f553f3dc72df6385fc"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.14.0/databricks-claude-linux-amd64"
      sha256 "e85fbd37ab3fcdaaff7852b724c5c4a92720f345e1fab394f7b3a045333c6bdc"
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
