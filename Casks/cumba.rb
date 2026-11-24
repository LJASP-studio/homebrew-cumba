cask "cumba" do
  version "1.4.1"
  sha256 "b1c76ed1e13bedcce6a8b16dd8f68743c1960c6ba230578f1217ea1dfd9d3f1e"

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
