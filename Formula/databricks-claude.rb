class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.8.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.8.1/databricks-claude-darwin-arm64"
      sha256 "e845cf507db3f726c6a012b16112d4f949b69cc2ca625d8da47acf291a7ac95c"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.8.1/databricks-claude-darwin-amd64"
      sha256 "f39e03ae2cd72943d2514cda630020b0dd8389fefbf6fc31a9eb14e55b56ae13"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.8.1/databricks-claude-linux-arm64"
      sha256 "f39906fa5c22f16d113c835cb1316c5f50d636d7ea467981d9c3dee9ec1c4716"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.8.1/databricks-claude-linux-amd64"
      sha256 "9182d3e32b00fc1b40b222569ebe7ab1a923a8aa75e37bd29d944070567ad77d"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "databricks-claude-#{os}-#{arch}" => "databricks-claude"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-claude --version 2>&1")
  end
end
