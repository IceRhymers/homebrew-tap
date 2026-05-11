class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.11.0/databricks-codex-darwin-arm64"
      sha256 "29b714f05b79d5a01692cfff7735e9c8dae309ecad8e8ec8491e6a5a9cbf97b9"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.11.0/databricks-codex-darwin-amd64"
      sha256 "ac4e521cacd9a86998aecad2777c5cdc8133dadbdc04519932983e9940dd68eb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.11.0/databricks-codex-linux-arm64"
      sha256 "f7fe4dada32601ef1735de4335eb485629a89a978d6b895efec8d01f913c56b2"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.11.0/databricks-codex-linux-amd64"
      sha256 "6db6f13d1fcc99d34907e4410c9482496a68e051da55be7d470bab9466a2e2c1"
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
