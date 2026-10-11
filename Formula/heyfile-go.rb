class HeyfileGo < Formula
  desc "Share and receive files over a local network"
  homepage "https://github.com/Mmx233/HeyFileGo"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://github.com/Mmx233/HeyFileGo/releases/download/v3.0.2/hey_darwin_arm64.tar.gz"
      sha256 "3d753b761346a39553f4b9f7db6339c057aab6ea38507734f5fbb27efbd8206f"
    end

    on_intel do
      url "https://github.com/Mmx233/HeyFileGo/releases/download/v3.0.2/hey_darwin_amd64.tar.gz"
      sha256 "cbb31c2f0a113bc38391f4297db08ca47b2e175e53dfb662eeb5e04770fe3b46"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Mmx233/HeyFileGo/releases/download/v3.0.2/hey_linux_arm64.tar.gz"
      sha256 "a93d7e7f6f3174f76a6ae3c155c9582527bb26a19f0af87ebdf8be5faf5ca5e2"
    end

    on_intel do
      url "https://github.com/Mmx233/HeyFileGo/releases/download/v3.0.2/hey_linux_amd64.tar.gz"
      sha256 "145d6ca866256bcd91cb100c8dc6253d0342050fd75a3a6e3ae07c1fd8be704c"
    end
  end

  conflicts_with "hey", because: "both install a hey executable"

  def install
    bin.install "hey"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hey --version")
    assert_match "--upload-concurrency", shell_output("#{bin}/hey --help")
  end
end
