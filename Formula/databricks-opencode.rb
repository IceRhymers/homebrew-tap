class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.3.0/databricks-opencode-darwin-arm64"
      sha256 "93d23238384abd2e555ecd128ff85abbfee1e0b896f72ad3b5c5303bf7defe1c"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.3.0/databricks-opencode-darwin-amd64"
      sha256 "91945feb16214c9c6167c0e87522aac3a2f2c7fa9611333163600049828a849f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.3.0/databricks-opencode-linux-arm64"
      sha256 "22b1901e06887d3778dfb56df5fb3dd8b86bec949d26abf5c923e4444ea5ba14"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.3.0/databricks-opencode-linux-amd64"
      sha256 "0ad8adcf9dbfa8cce475b9b375833c89afdd2f83b199b08d7e225529daf5e2c1"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "databricks-opencode-#{os}-#{arch}" => "databricks-opencode"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-opencode --version 2>&1")
  end
end
