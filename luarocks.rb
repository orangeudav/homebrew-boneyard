class Luarocks < Formula
  homepage "http://luarocks.org"
  url "http://luarocks.org/releases/luarocks-2.3.0.tar.gz"
  sha256 "68e38feeb66052e29ad1935a71b875194ed8b9c67c2223af5f4d4e3e2464ed97"

  head "https://github.com/keplerproject/luarocks.git"

  depends_on "lua"

  keg_only "Luarocks is being merged into Lua formulae imminently & this eases transition."

  fails_with :llvm do
    cause "Lua itself compiles with llvm, but may fail when other software tries to link."
  end

  def install
    # Install to the Cellar, but direct modules to HOMEBREW_PREFIX
    # Specify where the Lua is to avoid accidental conflict.
    lua_prefix = Formula["lua"].opt_prefix

    args = ["--prefix=#{prefix}",
            "--rocks-tree=#{HOMEBREW_PREFIX}",
            "--sysconfdir=#{etc}/luarocks",
            "--with-lua=#{lua_prefix}"]

    system "./configure", *args
    system "make", "build"
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    Rocks are installed to: #{HOMEBREW_PREFIX}/lib/luarocks/rocks

    A configuration file has been placed at #{HOMEBREW_PREFIX}/etc/luarocks
    which you can use to specify additional dependency paths as desired.    
    See: http://luarocks.org/en/Config_file_format
    EOS
  end

  test do
    system "#{bin}/luarocks", "install", "say"
  end
end
