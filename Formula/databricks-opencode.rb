class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.0.0/databricks-opencode-darwin-arm64"
      sha256 "030b6467d60dd150366b06297f4b06cff201c76a2f20997ce5e15e28f012ca04"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.0.0/databricks-opencode-darwin-amd64"
      sha256 "14c10c18e7d6044a71842a3e8555e619acdb52aab70fcff36de5eccc77ff8c17"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.0.0/databricks-opencode-linux-arm64"
      sha256 "d8d77c7c8729cca2feb5a1f750f10f48241e08ddc63a4f9554c96d677d1b7929"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v1.0.0/databricks-opencode-linux-amd64"
      sha256 "23f4dd4fa8cdb857fcc0aaca61ec5718775a8c0a919f4212876c76d4a6341150"
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
