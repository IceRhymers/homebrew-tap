class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.18.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.18.0/databricks-claude-darwin-arm64"
      sha256 "8059cd92a3223e129afb166ff3bca7042e7ca9200adf11c821a6a55da71cc5d7"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.18.0/databricks-claude-darwin-amd64"
      sha256 "25e81122b2c61228e01aab24cf10e455647e990f73a2bfe1b8bded3f72be03da"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.18.0/databricks-claude-linux-arm64"
      sha256 "45a9de92c58827fd9e31cac801f850eda52d23f979054d1008abeb9978ce02ed"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.18.0/databricks-claude-linux-amd64"
      sha256 "7c8e724d08fb45100114c13b7ba5ceec808f67b89f1a9652e73c8bac2e9ba09e"
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
