class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.5.0/databricks-codex-darwin-arm64"
      sha256 "13bda412ee738c189c489e872d39fd26a9b3efc713041bf3c8a87e26aed0b5af"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.5.0/databricks-codex-darwin-amd64"
      sha256 "1a1b963ef85a7074eb22a5030bd1a9f8476414ecf37006601a5ee50239700d82"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.5.0/databricks-codex-linux-arm64"
      sha256 "8890fa428c46b85ff2fffc4614943292c771b7f10dd9b300468d8b67f789fb67"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.5.0/databricks-codex-linux-amd64"
      sha256 "43fd6c0fa84d4ca39759f51611fccd80e9572ae49773ee30cc32c22e934f5ccd"
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
