class DatabricksCodex < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenAI Codex CLI"
  homepage "https://github.com/IceRhymers/databricks-codex"
  version "0.9.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.9.0/databricks-codex-darwin-arm64"
      sha256 "10e600328ab2f7a4d1f017fcb1f938b68a8b66d19b2af7db6e9584bd777d6c7a"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.9.0/databricks-codex-darwin-amd64"
      sha256 "cb241790c750f1e4337a0e5743476f8e79102db99baf27e265e008f90d5fdf09"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.9.0/databricks-codex-linux-arm64"
      sha256 "b5ecde2f177a982e3814d49f3ac6f6a63650368e73b3bb5aec0f185349284991"
    else
      url "https://github.com/IceRhymers/databricks-codex/releases/download/v0.9.0/databricks-codex-linux-amd64"
      sha256 "596638c6920f5e57a427408800270543e4404d96d7b99ae64fb56996f3ffc46c"
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
