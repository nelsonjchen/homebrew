require 'formula'

class Fox < Formula
  homepage 'http://www.fox-toolkit.org/'
  url 'ftp://ftp.fox-toolkit.org/pub/fox-1.6.49.tar.gz'
  sha1 '056a55ba7b4404af61d4256eafdf8fd0503c6fea'

  # Development and stable branches are incompatible
  devel do
    url 'ftp://ftp.fox-toolkit.org/pub/fox-1.7.45.tar.gz'
    sha1 'bdd50d1bcadb29ebeb634aba2bd6b887d328953b'
  end

  depends_on :x11

  def install
    # Yep, won't find freetype unless this is all set.
    ENV.append "CFLAGS", "-I#{MacOS::X11.include}/freetype2"
    ENV.append "CPPFLAGS", "-I#{MacOS::X11.include}/freetype2"
    ENV.append "CXXFLAGS", "-I#{MacOS::X11.include}/freetype2"

    system "./configure", "--enable-release",
                          "--prefix=#{prefix}",
                          "--with-x", "--with-opengl"
    system "make install"
  end
end
