class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "1.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.2/databricks-claude-darwin-arm64"
      sha256 "536631bbfe9e7a930eff3c73994857f1d606ab7dc478d879227fcc304c7f1244"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.2/databricks-claude-darwin-amd64"
      sha256 "88cbb734bed7e93de95e1f60313974531ede326bd37b421c2c4670f484e96fc0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.2/databricks-claude-linux-arm64"
      sha256 "7a485f9c989663d01e519aa9b440211744dbb86e8606ee5d9c2dabd5d0ca471d"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.2/databricks-claude-linux-amd64"
      sha256 "cb51a32f13b8673daf20d6cdb4ad5562d69ec14c28dbcc61b8169a6aaf90f4ba"
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
