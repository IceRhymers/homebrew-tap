class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.7.0/databricks-codex-darwin-arm64"
      sha256 "8666d790fbdd71e9f4e1b6f2e38aa480cb5f56bfdd248efe156ad673737bd8ef"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.7.0/databricks-codex-darwin-amd64"
      sha256 "cc01505d98cf30685a97a280a623d4fce129618a3cdc7385327940323ccf44ba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.7.0/databricks-codex-linux-arm64"
      sha256 "7f25aa3e5f1baa544a33801e1b3053eac87423b74cefe70153023a253f79b852"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.7.0/databricks-codex-linux-amd64"
      sha256 "5702f6c8290c431be2a39d667391bcf0568a4075896f6a892089a5923a9880e3"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "databricks-codex-#{os}-#{arch}" => "databricks-codex"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-codex --version 2>&1")
  end
end
