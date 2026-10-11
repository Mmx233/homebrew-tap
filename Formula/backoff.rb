class Backoff < Formula
  desc "Run commands with customizable backoff and health checks"
  homepage "https://github.com/Mmx233/BackoffCli"
  version "2.0.1"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    depends_on macos: :monterey

    on_arm do
      url "https://github.com/Mmx233/BackoffCli/releases/download/v2.0.1/backoff_darwin_arm64.tar.gz"
      sha256 "e2eb4ee757e3781b46a34b17801104aa7e73f98fe0f31ac3cedeab8206eb4452"
    end

    on_intel do
      url "https://github.com/Mmx233/BackoffCli/releases/download/v2.0.1/backoff_darwin_amd64.tar.gz"
      sha256 "33c5e6180a22f63c1faef2e06790964741ca84537881e4a38db2aa1f2bdac8b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Mmx233/BackoffCli/releases/download/v2.0.1/backoff_linux_arm64.tar.gz"
      sha256 "0ef5669a5c1e77f7e7372c89492f4af488cb546c527ad14a9a0809ee3c023f6b"
    end

    on_intel do
      url "https://github.com/Mmx233/BackoffCli/releases/download/v2.0.1/backoff_linux_amd64.tar.gz"
      sha256 "cb33177f72e94cb4125269897abd11784f4e8e533e0a4b4cc98694578c63248e"
    end
  end

  def install
    bin.install "backoff"
  end

  test do
    output = shell_output("#{bin}/backoff --retry.max=1 --no-singleton -- /bin/sh -c 'printf backoff-ok'")
    assert_match "backoff-ok", output
  end
end
