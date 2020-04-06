# coding: utf-8
class Yices2 < Formula
  desc "The Yices SMT Solver"
  homepage "https://yices.csl.sri.com/"
  url "https://github.com/SRI-CSL/yices2/archive/Yices-2.6.2.tar.gz"
  sha256 "7a32f9a3a12cebb07ca35ee593df4d7f8265ea432175297e9029760cc823e1f2"

  depends_on "autoconf" => :build
  depends_on "gperf" => :build
  depends_on "gmp"
  depends_on "libpoly"
  depends_on "cudd"
  depends_on "cadical"

  def install
    system "autoconf"
    system "./configure", "--enable-mcsat",
                          "CPPFLAGS=-DHAVE_CADICAL",
                          "LIBS=-lcadical -lstdc++ -lm",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"lra.smt2").write <<-EOS.undent
      ;; QF_LRA = Quantifier-Free Linear Real Arithemtic
      (set-logic QF_LRA)
      ;; Declare variables x, y
      (declare-fun x () Real)
      (declare-fun y () Real)
      ;; Find solution to (x + y > 0), ((x < 0) || (y < 0))
      (assert (> (+ x y) 0))
      (assert (or (< x 0) (< y 0)))
      ;; Run a satisfiability check
      (check-sat)
      ;; Print the model
      (get-model)
    EOS

    assert_match "sat\n(= x 2)\n(= y (- 1))\n", shell_output("#{bin}/yices-smt2 lra.smt2")
  end
end
