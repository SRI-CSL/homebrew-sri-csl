class Cadical < Formula
  desc "The CDCL SAT Solver CaDiCaL"
  homepage "https://github.com/arminbiere/cadical"
  url "https://github.com/SRI-CSL/cadical/archive/rel-1.2.2.tar.gz"
  sha256 "824d324979387064378da497f47920b140e14191c61e2250c1b7433e1c379992"

  def install
    system "./configure"
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "true"
  end
end
