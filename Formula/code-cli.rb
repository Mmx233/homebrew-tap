class CodeCli < Formula
  desc "Clone repositories and open projects in an IDE, terminal or browser"
  homepage "https://github.com/Mmx233/CodeCli"
  license "AGPL-3.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://github.com/Mmx233/CodeCli/releases/download/v2.0.1/code_darwin_arm64.tar.gz"
      sha256 "cda58c48cf657229819b68750e81af35845f590e11ee96fb2dac1b8297d0bdfb"
    end

    on_intel do
      url "https://github.com/Mmx233/CodeCli/releases/download/v2.0.1/code_darwin_amd64.tar.gz"
      sha256 "738ee22b5895b34e84462424c1c849f4c7fe8e085004b9efa9ff76d4e9d1f705"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Mmx233/CodeCli/releases/download/v2.0.1/code_linux_arm64.tar.gz"
      sha256 "7d22da2ed6fac9c4c7819ced1ad6c4f00ebbbae151057453ff24a27e2c99acaa"
    end

    on_intel do
      url "https://github.com/Mmx233/CodeCli/releases/download/v2.0.1/code_linux_amd64.tar.gz"
      sha256 "ced6e4f8b16bac03488aa543670a19c83f7a2bc7d72c262c84fe4a7af75b4ceb"
    end
  end

  def install
    bin.install "code"
  end

  def caveats
    <<~EOS
      This installs a code executable, which shares its name with the VS Code launcher.
      Existing code links are not overwritten automatically.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/code --version")
    assert_equal testpath.to_s, shell_output("#{bin}/code pwd").strip
  end
end
