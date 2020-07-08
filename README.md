# Grammar message

inspired by [Grammar::PrettyErrors](https://github.com/bduggan/p6-grammar
-prettyerrors), and ripping off the code used there for printing messages
, prints error messages highlighting the line and, if possible, the position
 where it last worked.

## Installing

    zef install Grammar::Message

## Running

```perl6
my $str = (('a'..'z').rotor(3).map: *.join("")).join("\n");
my $saved-match; # Saves in situ
$str ~~ / m { $saved-match = $/} /; # Code right behind match you need printed
say pretty-message( "Found", $saved-match);
```

Will print

```
Found
  3 │ ghi
  4 │ jkl
  5 │▶ mno
        ^
  6 │ pqr
  7 │ stu
  8 │ vwx
```

with highlights for the matching line. 

```perl6
$str .= subst( "m", "mm" );
G.parse( $str );
say pretty-message( "Some failure around here", $saved-match);
```

will print

```
Some failure around here
  4 │ jkl
  5 │ mmno
  6 │▶ pqr
     ^
  7 │ stu
  8 │ vwx

```

Take into account that the point will always be the best bet, and in any case
 it will reflect the state of the `pos` attribute of the Match at the point
  you saved it.
  
## See also

Original code by Brian Duggan in 
[`Grammar::PrettyErrors`](https://github.com/bduggan/p6-grammar-prettyerrors
) is the origin of this code.

## License

Respecting the original code license, this is also licensed under the
 Artistic license (included).
