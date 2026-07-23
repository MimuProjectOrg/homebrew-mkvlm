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
  url "https://github.com/MimuProjectOrg/mkvlm/archive/refs/tags/v1.12.0.tar.gz"
  sha256 "f6efba866915eb3b1c12afed2d0bd3d7bf77b578d8300abd742c24b93a3901af"
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
