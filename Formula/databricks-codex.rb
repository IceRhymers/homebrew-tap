class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "0.7.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.7.1/databricks-codex-darwin-arm64"
      sha256 "0c40542a3d568377b059d104cfde6dbd8785f39be88b92805a155edc7a2fab29"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.7.1/databricks-codex-darwin-amd64"
      sha256 "d1227115cb319b9b4a087f93f496820764ef34094cc4146748115b247a34b37a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.7.1/databricks-codex-linux-arm64"
      sha256 "5e1242ae361544229eb59f3c10e7606631f2ae538bc37fee0ac6e9c20bddccf4"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.7.1/databricks-codex-linux-amd64"
      sha256 "3595c36e704672ec57b2e3dede1bcaa577bd6ec42e95d8f88f4ad3d73b767163"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    binary = "databricks-codex-#{os}-#{arch}"
    chmod "+x", binary
    bin.install binary => "databricks-codex"
    generate_completions_from_executable(bin/"databricks-codex", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-codex --version 2>&1")
    assert_match "databricks-codex", shell_output("#{bin}/databricks-codex completion bash")
    assert_match "databricks-codex", shell_output("#{bin}/databricks-codex completion zsh")
    assert_match "databricks-codex", shell_output("#{bin}/databricks-codex completion fish")
  end
end
