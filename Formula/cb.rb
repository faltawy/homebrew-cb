class Cb < Formula
  desc "A fast clipboard manager for macOS with history, search, tags, and a TUI"
  homepage "https://github.com/faltawy/cb"
  license "MIT"
  version "0.1.0"

  if Hardware::CPU.arm?
    url "https://github.com/faltawy/cb/releases/download/v#{version}/cb-v#{version}-aarch64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_ARM64_SHA256"
  else
    url "https://github.com/faltawy/cb/releases/download/v#{version}/cb-v#{version}-x86_64-apple-darwin.tar.gz"
    sha256 "PLACEHOLDER_X86_64_SHA256"
  end

  def install
    bin.install "cb"
  end

  def caveats
    <<~EOS
      To start watching your clipboard:
        cb daemon start

      To run the daemon automatically at login, create a LaunchAgent:
        mkdir -p ~/Library/LaunchAgents
        cat > ~/Library/LaunchAgents/com.faltawy.cb.plist << PLIST
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>com.faltawy.cb</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/cb</string>
            <string>daemon</string>
            <string>run</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>KeepAlive</key>
          <true/>
        </dict>
        </plist>
        PLIST
        launchctl load ~/Library/LaunchAgents/com.faltawy.cb.plist
    EOS
  end

  test do
    system bin/"cb", "stats"
  end
end
