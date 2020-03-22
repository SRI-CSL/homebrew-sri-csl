class Cadical < Formula
  desc "The CDCL SAT Solver CaDiCaL"
  homepage "https://github.com/arminbiere/cadical"
  url "https://github.com/arminbiere/cadical/archive/rel-1.2.1.tar.gz"
  sha256 "0e5075d3cf84403f7ed010a289cfc495ae056aee0d4892fe11e11a395858d4a2"

  def install
    system "./configure"
    system "make"
    # damn thing doesn't have an install target
    cp "./build/libcadical.a", lib.to_s
    cp "./src/cadical.hpp", include.to_s
  end

  test do
    system "true"
  end
end
