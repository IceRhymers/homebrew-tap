class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "2.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v2.0.0/databricks-codex-darwin-arm64"
      sha256 "f2b3edff356e973e24fcd03cec1015f928b49ff677331c10e68a32cb15c7ab1e"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v2.0.0/databricks-codex-darwin-amd64"
      sha256 "f0fb52cd9cc98f6ca6078c05ed4876db17e0986aedba84b896c5780844b863d2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v2.0.0/databricks-codex-linux-arm64"
      sha256 "d971759aaa2bbc86f7dd1b6746a2031e92bfee9aab097e4dafcc0530a77b836b"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v2.0.0/databricks-codex-linux-amd64"
      sha256 "167e74d95ba40ea5ce6dd886f32ad870f39a3d916d0ec87ae9a2018a17813d59"
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
