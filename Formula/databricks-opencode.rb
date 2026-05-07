class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.7.0/databricks-opencode-darwin-arm64"
      sha256 "c15136943e9c4acad303fddaad98986b8fdc7a9240bbb0fdbc03a5c8becec778"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.7.0/databricks-opencode-darwin-amd64"
      sha256 "89177c57dae81a0c63aa0d1280bcf54f0db599fbaa0156424840a101fa6cb401"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.7.0/databricks-opencode-linux-arm64"
      sha256 "48b0ce2e4af9e76cd2ed1a1e7ce6baec043104e3484b70e9b695e2132d747f76"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.7.0/databricks-opencode-linux-amd64"
      sha256 "859c9143530618ff171de7da528bea0ca1a62072c4131b5dddb7c93bbdaed48a"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    binary = "databricks-opencode-#{os}-#{arch}"
    chmod "+x", binary
    bin.install binary => "databricks-opencode"
    generate_completions_from_executable(bin/"databricks-opencode", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-opencode --version 2>&1")
    assert_match "databricks-opencode", shell_output("#{bin}/databricks-opencode completion bash")
    assert_match "databricks-opencode", shell_output("#{bin}/databricks-opencode completion zsh")
    assert_match "databricks-opencode", shell_output("#{bin}/databricks-opencode completion fish")
  end
end
