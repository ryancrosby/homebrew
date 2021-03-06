require 'formula'

class Sqlcipher < Formula
  homepage "http://sqlcipher.net"
  url "https://github.com/sqlcipher/sqlcipher/archive/v2.1.1.tar.gz"
  sha1 "032110255562e9ada5f31078dc8426441a47a7ce"

  head "https://github.com/sqlcipher/sqlcipher.git"

  option 'with-fts', 'Enable the FTS module'

  keg_only "SQLCipher conflicts with the system and Homebrew SQLites."

  def install
    ENV.append 'CPPFLAGS', "-DSQLITE_ENABLE_FTS3 -DSQLITE_ENABLE_FTS3_PARENTHESIS" if build.include? "with-fts"

    system "./configure", "--prefix=#{prefix}", "--enable-tempstore=yes",
                          "CFLAGS=-DSQLITE_HAS_CODEC", "LDFLAGS=-lcrypto",
                          "--disable-tcl"
    system "make"
    system "make install"
  end
end
