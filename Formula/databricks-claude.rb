class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "1.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.1/databricks-claude-darwin-arm64"
      sha256 "4d9813de4bf3cf9fde303fa20ca30656f6667c7e3e9b9b856fef17b8d5d1d5e3"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.1/databricks-claude-darwin-amd64"
      sha256 "2cb8c2af006a8b9fb21db1aeda32f766b68f0eb53aebca4b38f06117b20b216d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.1/databricks-claude-linux-arm64"
      sha256 "f8badff4d4ad48ef44ee81eee8761c3ed6166d6407bb3c89dba7d811031f6040"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v1.0.1/databricks-claude-linux-amd64"
      sha256 "16c8c14e6fcdfba50fd0807f77dd10f5312518dd4bc9606e220b902fbd0a7c13"
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
