# The formula published to Marijusaj/homebrew-tap as Formula/savras.rb.
#
# This copy is a template: the release workflow fills in 0.1.5 and 35bac9e5858a514c49278963dba0fe38ce42937cf79219210a36a23bf2dc02af
# from the tag it was pushed for, and pushes the result to the tap. Edit it
# here, never in the tap — the next release would overwrite the tap's copy.
class Savras < Formula
  desc "Side panel that sees every Claude Code session you have running"
  homepage "https://github.com/Marijusaj/savras"
  url "https://github.com/Marijusaj/savras/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "35bac9e5858a514c49278963dba0fe38ce42937cf79219210a36a23bf2dc02af"
  license "MIT"
  head "https://github.com/Marijusaj/savras.git", branch: "main"

  depends_on "rust" => :build
  # The panel hosts sessions in tmux. `claude` itself is needed too, but it is a
  # cask and a formula cannot depend on one — the caveats say so instead.
  depends_on "tmux"

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      savras watches Claude Code sessions, so it needs `claude` on your PATH:
        https://docs.claude.com/en/docs/claude-code
    EOS
  end

  # `brew test` has no terminal, so the panel itself cannot start here.
  test do
    assert_match version.to_s, shell_output("#{bin}/svr --version")
  end
end
