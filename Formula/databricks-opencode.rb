class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.1.0/databricks-opencode-darwin-arm64"
      sha256 "57907003699bf595c20ce04bb5645881503dee4252ead831c271fb7f4aeb87bc"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.1.0/databricks-opencode-darwin-amd64"
      sha256 "9455957ace620742a86a8764116eb6d0cc740ccc3d22726d55016ee8316dbfbe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.1.0/databricks-opencode-linux-arm64"
      sha256 "1dfdf1789c8e417030959d3e27c12e74fab3ca425b42248451a4341431c86c38"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.1.0/databricks-opencode-linux-amd64"
      sha256 "bef1c1137de403708a6eface02578a99970d29e41e0a4c965c803d640b3e5c55"
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
