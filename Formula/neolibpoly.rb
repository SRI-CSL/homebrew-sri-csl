class NeoLibpoly < Formula
  desc "C library for manipulating polynomials"
  homepage "https://github.com/SRI-CSL/libpoly"
  url "https://github.com/SRI-CSL/libpoly/archive/v0.1.7.tar.gz"
  sha256 "71d08cc1e97219bde8a0af60dd436ce4266dc3f19ff3a2cabc640bd14f4d8f4d"

  depends_on "cmake" => :build
  depends_on "gmp"

  def install
    cd "build" do
      system "cmake", "..", 
                      "-DLIBPOLY_BUILD_PYTHON_API=OFF", 
                      "-DLIBPOLY_BUILD_STATIC=OFF", 
                      "-DLIBPOLY_BUILD_STATIC_PIC=OFF", 
                      "-DCMAKE_BUILD_TYPE=Release", 
                      "-DCMAKE_INSTALL_PREFIX=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
    #include <poly/rational.h>
    #include <stdlib.h>

    int main(int argc, char *argv[]) {
        lp_rational_t *q;
        q = (lp_rational_t*)malloc(sizeof(lp_rational_t));
        lp_rational_construct_from_double(q, 5);
        printf("%lf", lp_rational_to_double(q));
        return 0;
    }
    EOS

    system ENV.cc, "test.c", "-o", "test", "-I#{include}/poly", "-lpoly"
    assert_match "5.000000", shell_output("./test")
  end
end
