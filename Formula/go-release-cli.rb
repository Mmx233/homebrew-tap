class GoReleaseCli < Formula
  desc "Build and package Go programs for multiple platforms"
  homepage "https://github.com/Mmx233/GoReleaseCli"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go"

  on_macos do
    depends_on "gnu-tar"
    depends_on macos: :monterey

    on_arm do
      url "https://github.com/Mmx233/GoReleaseCli/releases/download/v1.4.8/release_darwin_arm64.tar.gz"
      sha256 "b9e5d4644454a2dc438abcd29a030f6e3971e99f67a624caf3879b5037fc9527"
    end

    on_intel do
      url "https://github.com/Mmx233/GoReleaseCli/releases/download/v1.4.8/release_darwin_amd64.tar.gz"
      sha256 "8403c325f5f4ac4f966b2d463d94ce61d31d351eb37df59009ccd659ee504086"
    end
  end

  on_linux do
    depends_on "zip"

    on_arm do
      url "https://github.com/Mmx233/GoReleaseCli/releases/download/v1.4.8/release_linux_arm64.tar.gz"
      sha256 "bd5e3902407bec6c886f074b827305b6c37623462648cf21a10a8c928379e719"
    end

    on_intel do
      url "https://github.com/Mmx233/GoReleaseCli/releases/download/v1.4.8/release_linux_amd64.tar.gz"
      sha256 "f37fcaf2f5e0582d125e302ad902d600d68b6e6bf930a26e540c0cb2920ee906"
    end
  end

  def install
    libexec.install "release"
    release_path = "#{formula_opt_bin("go")}:$PATH"
    release_path = if OS.mac?
      "#{formula_opt_libexec("gnu-tar")}/gnubin:#{release_path}"
    else
      "#{formula_opt_bin("zip")}:#{release_path}"
    end
    (bin/"release").write_env_script libexec/"release", PATH: release_path
  end

  test do
    (testpath/"go.mod").write "module example.com/tap-test\n\ngo 1.24.0\n"
    (testpath/"main.go").write <<~GO
      package main
      import "fmt"
      func main() { fmt.Println("release-ok") }
    GO
    ENV["GOCACHE"] = (testpath/"go-cache").to_s
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    system bin/"release", testpath, "--os", os, "--arch", arch,
           "--output", testpath/"dist", "--name", "hello", "-c", "tar.gz"
    system "tar", "-xzf", testpath/"dist/hello_#{os}_#{arch}.tar.gz", "-C", testpath
    assert_equal "release-ok\n", shell_output("#{testpath}/hello")
  end
end
