class Cudd < Formula
  desc "CUDD: CU Decision Diagram package - unofficial git mirror of http://vlsi.colorado.edu/~fabio/"
  homepage "https://github.com/ivmai/cudd"
  url "https://github.com/ivmai/cudd/archive/cudd-3.0.0.tar.gz"
  sha256 "5fe145041c594689e6e7cf4cd623d5f2b7c36261708be8c9a72aed72cf67acce"


  def install
    system "./configure", "CC=clang",
                          "CXX=clang++",
                          "--enable-silent-rules", 
                          "--enable-shared", 
                          "--enable-obj",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    system "true"
  end
end
