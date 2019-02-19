class LlvmLite < Formula
  desc "Next-gen compiler infrastructure"
  homepage "https://llvm.org/"

  stable do
    url "https://releases.llvm.org/6.0.0/llvm-6.0.0.src.tar.xz"
    sha256 "1ff53c915b4e761ef400b803f07261ade637b0c269d99569f18040f3dcee4408"
  end

  bottle do
    cellar :any
    sha256 "6e8c461f99e8b2725bb9c34d7fc548490f1e74f162f75f3670e0bd759dcbd473" => :high_sierra
    sha256 "3603e0a48860d079c9cdf32c6f65f87758bbfca4ab9aa6e2eb8b4d47a7751688" => :sierra
    sha256 "2ce6aed36aab360b9ec09c094727c76c6620bcf201802f5d5d59035c7e6c80f2" => :el_capitan
  end

  keg_only :provided_by_macos

  depends_on "cmake" => :build

  # According to the official llvm readme, GCC 4.7+ is required
  # fails_with :gcc_4_0
  # fails_with :gcc
  #  ("4.3".."4.6").each do |n|
  # fails_with :gcc => n
  # end

  def install
    args = %w[
      -DLLVM_OPTIMIZED_TABLEGEN=ON
      -DLLVM_INCLUDE_DOCS=OFF
      -DLLVM_INSTALL_UTILS=ON
      -DLLVM_TARGETS_TO_BUILD=all
    ]
    args << "-DLIBOMP_ARCH=x86_64"
    args << "-DLLVM_CREATE_XCODE_TOOLCHAIN=ON"
    args << "-DLLVM_BUILD_LLVM_DYLIB=ON"

    mktemp do
      system "cmake", "-G", "Unix Makefiles", buildpath, *(std_cmake_args + args)
      system "make"
      system "make", "install"
      system "make", "install-xcode-toolchain"
    end

  end

  test do
    assert_equal prefix.to_s, shell_output("#{bin}/llvm-config --prefix").chomp
  end
end
