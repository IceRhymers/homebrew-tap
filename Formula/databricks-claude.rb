class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.15.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.15.0/databricks-claude-darwin-arm64"
      sha256 "9e81effbea90970291244f84792010307777916293619b5772511b38a6001c15"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.15.0/databricks-claude-darwin-amd64"
      sha256 "fdf55d91db206e511beb6e969b3401fdf58d7ce02056404ef22ac75ac0b13cc4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.15.0/databricks-claude-linux-arm64"
      sha256 "f6cc9c8ce5564d4bc825cee9c4901c1e3137e0f510f1f264b6641061afaca1f5"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.15.0/databricks-claude-linux-amd64"
      sha256 "12723fc5426cc90387030d0580c563c9ae8005828f7784f2303d6ce34467cc96"
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
