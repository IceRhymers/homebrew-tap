class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.4.1/databricks-opencode-darwin-arm64"
      sha256 "9b3924bf175f68437fae0db843bd865e350adff7a592a4e427b767611ba8c179"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.4.1/databricks-opencode-darwin-amd64"
      sha256 "cc3f46a5a783c1ee38a3a2a8ed7fd3aba54473d277e108e9581cf22501286ee2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.4.1/databricks-opencode-linux-arm64"
      sha256 "256ead226c8c37dc1fbc8c42282edd11c4428b399c9264ca037e166bac73a56d"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.4.1/databricks-opencode-linux-amd64"
      sha256 "fb012fbb0143bfa880c0f45ce7972e8556ff38fa89f51d555a0af3f540cb0234"
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
