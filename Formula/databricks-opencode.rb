class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.2.0/databricks-opencode-darwin-arm64"
      sha256 "e82fc942136dfd771256d33657fb8ec01c032281c7f75c7d0f2044dd5b07f64f"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.2.0/databricks-opencode-darwin-amd64"
      sha256 "7dd94fb902727d9402303d4273e75717ce37f33e598a18686557b1fa94ef4386"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.2.0/databricks-opencode-linux-arm64"
      sha256 "8ae09743e3e01d277365e2fe326c749c317471c10d3fa43f064cfd0684a94d0c"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.2.0/databricks-opencode-linux-amd64"
      sha256 "1d68820325745331ece01679da25bc08fbee09a21fb07c2f6a3156d61c750e0f"
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
