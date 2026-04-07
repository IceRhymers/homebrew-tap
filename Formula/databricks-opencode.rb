class DatabricksOpencode < Formula
  desc "Transparent Databricks AI Gateway proxy for OpenCode CLI"
  homepage "https://github.com/IceRhymers/databricks-opencode"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.2.0/databricks-opencode-darwin-arm64"
      sha256 "a654d9c125ca2c19099f130ca02944fb7017ee788563fefa81cd8df3bbf0c2e6"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.2.0/databricks-opencode-darwin-amd64"
      sha256 "db2608a56aeac97783ed18d84cbaabbe906b965bccfa253543a7db8eff5537b9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.2.0/databricks-opencode-linux-arm64"
      sha256 "c01f635bf68b2b9d189a658cab9cc2291aaee2c19bc28f67205981eacd7f6c55"
    else
      url "https://github.com/IceRhymers/databricks-opencode/releases/download/v0.2.0/databricks-opencode-linux-amd64"
      sha256 "0b194bd15bfbd6308321b7499d5e95b34559b9082c324866baf9ef1b4558b5b4"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "databricks-opencode-#{os}-#{arch}" => "databricks-opencode"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/databricks-opencode --version 2>&1")
  end
end
