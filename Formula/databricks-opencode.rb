class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.4.0/databricks-opencode-darwin-arm64"
      sha256 "555c283117e37cb3a50aa2f234bc9b65462e50695d927c53510e68606e75420e"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.4.0/databricks-opencode-darwin-amd64"
      sha256 "552d3b50b9933db0d0ab0e92392196f46474bab7f8c3aa28ae1184293ea14b9f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.4.0/databricks-opencode-linux-arm64"
      sha256 "3acff2aa39498480c76febd0664b32a3ff57a0c567e01b154aa1fd4aaeb85431"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.4.0/databricks-opencode-linux-amd64"
      sha256 "e40c2c28ead8453d8212f6c73247823127640ef962b989795c213ae54cfd3467"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "databricks-opencode-#{os}-#{arch}" => "databricks-opencode"
    generate_completions_from_executable(bin/"databricks-opencode", "completion", shell_parameter_format: :arg)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-opencode --version 2>&1")
  end
end
