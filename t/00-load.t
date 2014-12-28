#!perl

use Test::More tests => 2;
BEGIN {
    use_ok('Crypt::Hill')        || print "Bail out!";
    use_ok('Crypt::Hill::Utils') || print "Bail out!";
}
