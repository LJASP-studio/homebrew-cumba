cask "cumba" do
  version "1.4.0"
  sha256 "8aab7e9f9c3160fe278d31893f086ed3aa128f5e4901f8a382c4b3748dde6709"

  url "https://github.com/LJASP-studio/Cumba/releases/download/v#{version}/Cumba-v#{version}.dmg"
  name "Cumba"
  desc "Notch panel for media, AI coding agents and widgets"
  homepage "https://cumbanotch.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "Cumba.app"

  # Cumba isn't notarized, so Gatekeeper would block the first launch. This removes the
  # download flag from the installed app, the same as the README's Terminal alternative to
  # Open Anyway. Homebrew has already checked the download against the sha256 above.
  postflight_steps do
    if_path_exists "{{appdir}}/Cumba.app" do
      run "/usr/bin/xattr",
          args: ["-dr", "com.apple.quarantine", "{{appdir}}/Cumba.app"]
    end
  end

  uninstall quit: "io.github.muazfurkan.ljaspnotch"

  zap trash: [
    "~/Library/Application Support/Cumba",
    "~/Library/Preferences/io.github.muazfurkan.ljaspnotch.plist",
  ]

  caveats <<~EOS
    If you use the Claude Code or Codex hooks, remove them in
    Settings > Agents before you uninstall Cumba.
  EOS
end
