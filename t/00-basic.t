use Test;

use Grammar::Message;

my $str = q:to/EOS/;
a
b
c
EOS

my $saved-match;
$str ~~ / a { $saved-match = $/} /;
my $msg = pretty-message( "Found", $saved-match);
ok( $msg, "Produced message");
like $msg, /"^"/, "Pointer created";

$str = (('a'..'z').rotor(3).map: *.join("")).join("\n");

$str ~~ / m { $saved-match = $/} /;
say $msg;

done-testing;
