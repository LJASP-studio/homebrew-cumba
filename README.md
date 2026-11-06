# Homebrew tap for Cumba

[Cumba](https://github.com/LJASP-studio/Cumba) is a free, open source notch app for macOS by LJASP ([cumbanotch.com](https://cumbanotch.com)).

```bash
brew install --cask ljasp-studio/cumba/cumba
```

- Update: `brew upgrade --cask cumba`
- Uninstall: `brew uninstall --cask cumba`. Add `--zap` to delete its settings, themes and notes too. If you use the Claude Code or Codex hooks, remove them in Cumba's **Settings > Agents** first. The tokens stay in the Keychain; [Cumba's README](https://github.com/LJASP-studio/Cumba#uninstall) shows how to delete them.

## What the cask does

1. Downloads `Cumba-vX.Y.Z.dmg` from [Cumba's latest release](https://github.com/LJASP-studio/Cumba/releases/latest) and checks it against the SHA-256 in [the cask](Casks/cumba.rb).
2. Copies `Cumba.app` to your Applications folder. It needs macOS 26 or later.
3. Removes macOS's download flag (`com.apple.quarantine`) from `Cumba.app`.

Step 3 is there because Cumba isn't notarized by Apple (that needs a paid developer account), so macOS would block its first launch until you click **Open Anyway** in System Settings. [Why macOS warns](https://github.com/LJASP-studio/Cumba#why-macos-warns) explains what that warning means. If you'd rather see it and decide for yourself, download the `.dmg` from the release page instead of using this tap.

## How new versions get here

[A workflow](.github/workflows/update.yml) looks for a new Cumba release every six hours. Before it changes the cask, the `.dmg` must match the release's `SHA256SUMS.txt` and carry signed build provenance showing that Cumba's release workflow built it from the public code (`gh attestation verify`). Only GitHub's own actions run here, pinned to commit SHAs.

You can check an installed copy the same way:

```bash
gh attestation verify "$(brew --cache --cask cumba)" --repo LJASP-studio/Cumba
```

## Security

Please report security issues privately in Cumba's repository, as its [security policy](https://github.com/LJASP-studio/Cumba/blob/main/SECURITY.md) describes.

## License

[MIT](LICENSE)
