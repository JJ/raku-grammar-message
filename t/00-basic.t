use Test;

use Grammar::Message;

my $str = q:to/EOS/;
a
b
c
EOS

my $saved-match;
$str ~~ / a { say $/.pos; $saved-match = $/} /;
say pretty-message( "Found", $saved-match);

done-testing;
