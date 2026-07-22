# Homebrew formula for mkvlm.
#
# This is the canonical source for the formula shipped in the `mimuprojectorg/mkvlm`
# tap (the repo behind `brew tap mimuprojectorg/mkvlm`). On each release, copy this
# file into the tap, then update `url`, `sha256`, and (if the layout changed)
# the `install` block.
#
# To compute the sha256 for a tag after it is pushed:
#
#   curl -fsSL https://github.com/MimuProjectOrg/mkvlm/archive/refs/tags/vx.y.z.tar.gz \
#     | shasum -a 256
#
class Mkvlm < Formula
  desc "Create and manage macOS sparse bundle disk images"
  homepage "https://github.com/MimuProjectOrg/mkvlm"
  url "https://github.com/MimuProjectOrg/mkvlm/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "5414296bee0cc2cd9d65a57f96a9c29ec6185e56af3abd2391f7d76ea351fb14"
  license "MIT"
  head "https://github.com/MimuProjectOrg/mkvlm.git", branch: "main"

  depends_on :macos

  def install
    bin.install "scripts/mkvlm" => "mkvlm"
    man1.install "man/mkvlm.1"
    zsh_completion.install "completions/_mkvlm"
    bash_completion.install "completions/mkvlm.bash" => "mkvlm"
    fish_completion.install "completions/mkvlm.fish"
    # mkvlm resolves its version from a VERSION file two directories above the
    # executable; installing it into the keg root keeps `--version` authoritative.
    prefix.install "VERSION"
  end

  test do
    assert_match "mkvlm #{version}", shell_output("#{bin}/mkvlm --version")
  end
end
