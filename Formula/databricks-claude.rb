class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.16.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.16.0/databricks-claude-darwin-arm64"
      sha256 "1a0712e47a3c0030f1ae5dc42cb7b2b08402409af6b4e5897602dc77955056d7"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.16.0/databricks-claude-darwin-amd64"
      sha256 "77df63f07a0189696677a159344b94b55c0e0b69498f14c4622a76e8410546bb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.16.0/databricks-claude-linux-arm64"
      sha256 "a0515f9bd23df82e96142f9d8f74cb68ad1b08230c22f374b51f5cfdef673ce6"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.16.0/databricks-claude-linux-amd64"
      sha256 "0716690e07f5560ef832dac100133db8152cfda3e45c1025a00321f370fd5c14"
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
