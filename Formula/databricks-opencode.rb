class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.6.0/databricks-opencode-darwin-arm64"
      sha256 "6a7cec4aede2e9a88433fd415ecf742ca97fa0f71de5c2e8cb25c726037a09da"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.6.0/databricks-opencode-darwin-amd64"
      sha256 "da438ce9873a27020e3e72b6a25c35265df0b0f2418a13dd44aa98b5a4606078"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.6.0/databricks-opencode-linux-arm64"
      sha256 "c84109e1c63bf4087eb7c2361fab73a5ae98f37a556509fe37bfa6b088f257db"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.6.0/databricks-opencode-linux-amd64"
      sha256 "b03b6521942ec6aacad21a21982961f1c221369ff3aec21a36393f6b1f5044ae"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    binary = "databricks-opencode-#{os}-#{arch}"
    chmod "+x", binary
    bin.install binary => "databricks-opencode"
    generate_completions_from_executable(bin/"databricks-opencode", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-opencode --version 2>&1")
    assert_match "databricks-opencode", shell_output("#{bin}/databricks-opencode completion bash")
    assert_match "databricks-opencode", shell_output("#{bin}/databricks-opencode completion zsh")
    assert_match "databricks-opencode", shell_output("#{bin}/databricks-opencode completion fish")
  end
end
