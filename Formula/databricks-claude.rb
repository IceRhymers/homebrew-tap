class DatabricksClaude < Formula
  desc "Transparent Databricks AI Gateway proxy for Claude Code"
  homepage "https://github.com/IceRhymers/databricks-claude"
  version "0.9.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.9.1/databricks-claude-darwin-arm64"
      sha256 "9a28c1377dde3313e714847b8ea4b5e0763ee1cc64ffd64e1cf0e1ad788b4ca9"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.9.1/databricks-claude-darwin-amd64"
      sha256 "b1055aae527f0c4e8ccd0b2d2795f831f5b0eb1706f8dd4beb6f030e45d22d49"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.9.1/databricks-claude-linux-arm64"
      sha256 "7042c1579f7942d5143dff5512dda7aa8ac88c38b354de50e664fd9faa86fe6d"
    else
      url "https://github.com/IceRhymers/databricks-claude/releases/download/v0.9.1/databricks-claude-linux-amd64"
      sha256 "b318a7a64af5b465237fd64dceb47142b4882417b0440755589f2d649f000ffb"
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
