class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.5.0/databricks-opencode-darwin-arm64"
      sha256 "a81968741955410eac21f1076fe5c5d748ae910c5d74c1d5420c3d3a77d9e311"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.5.0/databricks-opencode-darwin-amd64"
      sha256 "2e3b00ad61874620d631a81bf8c45de20f96933547e049555461636d8577e352"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.5.0/databricks-opencode-linux-arm64"
      sha256 "ff406644790ef1acc24d29f13a1fb0112e4addc48906e8b2c922c587453f4573"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.5.0/databricks-opencode-linux-amd64"
      sha256 "2ebe17a4844c614bfeb52944ae393e3b989b1c2cf28f1a6e607270ff87c85e8e"
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
