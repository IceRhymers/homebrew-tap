class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.19.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.19.0/databricks-claude-darwin-arm64"
      sha256 "a98829b408261a0972bae461b15fa656cc07d56f2f8e5cc2cd27737015c576d7"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.19.0/databricks-claude-darwin-amd64"
      sha256 "6daa725ea57c7f51534ec35abdab16e53c19a0d17bd60ca576b31887b7f6ba2e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.19.0/databricks-claude-linux-arm64"
      sha256 "46f79d3920e81de03b0503e9e6e5c2dfb5f8d98c7176f7cfc15f496a50711215"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.19.0/databricks-claude-linux-amd64"
      sha256 "a7b8ccf58f8db710fd237b2efde090a9cc84b117d700cd2687e64f60b044e406"
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
