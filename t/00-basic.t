use Test; # -*- mode: perl6 -*-

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
$msg = pretty-message( "Found", $saved-match);
like $msg.lines[4], /"^"/, "Pointer created";
done-testing;

grammar G {
    token TOP { <letters>+ % \v}
    token letters { { $saved-match = $/} \w ** 3 }
}

$str .= subst( "m", "mm" );

nok G.parse( $str ), "Parse fails";
$msg = pretty-message( "Some failure around here", $saved-match);
like $msg.lines[4], /"^"/, "Pointer created";


