class Synfigstudio < Formula
  desc "Vector-based 2D animation package"
  homepage "http://synfig.org"
  url "https://downloads.sourceforge.net/project/synfig/releases/1.0/source/synfigstudio-1.0.tar.gz"
  sha256 "2b23916ca0be4073edad9b0cb92fd30311dd3b8f73372c836ba735100251ee28"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "libsigc++"
  depends_on "gtkmm3"
  depends_on "etl"
  depends_on "synfig"

  needs :cxx11

  # bug filed upstream as http://www.synfig.org/issues/thebuggenie/synfig/issues/904
  patch do
    url "https://gist.githubusercontent.com/tschoonj/91fd64c528c7b971f185/raw/85dca7ef41f118007676bb0ca58b978693ee3d4e/synfigstudio.diff"
    sha256 "ae16c0086256f266ffdef7ea758b5385b869833e04562b7d9194da6101b24f2f"
  end

  def install
    ENV.cxx11
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # executable doesnt take options that will stop the gui from spawning
    assert (share/"appdata/synfigstudio.appdata.xml").exist?
  end
end
