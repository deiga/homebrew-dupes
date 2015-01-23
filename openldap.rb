require 'formula'

class Openldap < Formula
  homepage 'http://www.openldap.org/software/'
  url 'ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.39.tgz'
  sha256 '8267c87347103fef56b783b24877c0feda1063d3cb85d070e503d076584bf8a7'

  depends_on 'berkeley-db' => :optional
  depends_on 'openssl'

  option 'with-memberof', 'Include memberof overlay'
  option 'with-unique', 'Include unique overlay'
  option 'with-sssvlv', 'Enable server side sorting and virtual list view'

  def install
    args = %W[--disable-dependency-tracking
              --prefix=#{prefix}
              --sysconfdir=#{etc}
              --localstatedir=#{var}]
    args << "--enable-bdb=no" << "--enable-hdb=no" if build.without? "berkeley-db"
    args << "--enable-memberof" if build.with? "memberof"
    args << "--enable-unique" if build.with? "unique"
    args << "--enable-sssvlv=yes" if build.with? "sssvlv"

    system "./configure", *args
    system "make install"
    (var+'run').mkpath
  end
end
