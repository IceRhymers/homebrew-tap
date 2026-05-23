class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v1.0.0/databricks-codex-darwin-arm64"
      sha256 "637609de188509e5a589caac9b324ec3f7f2fec46aea3c7b059c00da8dbc981b"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v1.0.0/databricks-codex-darwin-amd64"
      sha256 "14a53f4fe75824291f590de6dc3d73e4114401e77394d5769e0ba78a558f2155"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v1.0.0/databricks-codex-linux-arm64"
      sha256 "7da24282d76736af04a4a74fe52e7bedbb8dea8bfabbb6d3a9228919e6f5f597"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v1.0.0/databricks-codex-linux-amd64"
      sha256 "bb534028333f1676867e858a4ba6294fef797daa3e92cb45105902033405867e"
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
