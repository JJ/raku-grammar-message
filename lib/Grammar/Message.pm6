use Terminal::ANSIColor;

unit module Grammar::Message;

sub pretty-message( Str $msg, Match $match ) is export {
    my @msg = [$msg];
    my @lines = $match.target.lines;
    my @lines-ranges;
    my $initial-char = 0;
    my $line-no = 0;
    for @lines -> $l {
        my $final-char = $initial-char + -1 + $l.chars;
        @lines-ranges.push:
                $l => $initial-char .. $final-char;
        $line-no = @lines-ranges.elems - 1
            if $initial-char <= $match.pos <= $final-char;
        $initial-char = $final-char + 1;
    }
    my $first = ( ($line-no - 3) max 0 );
    my @near = @lines[ $first.. (($line-no + 3) min @lines-1) ];
    my $i = $line-no - 3 max 0;

    for @near {
        $i++;
        if $i==$line-no {
            my $column = $match.pos - @lines-ranges[$i].value.min +1;
            @msg.push: color('bold yellow') ~ $i.fmt("%3d") ~ " │▶ $_" ~ color('reset');
            @msg.push: "     " ~ '^'.indent($column);
        } else {
            @msg.push: color('green') ~ $i.fmt("%3d") ~ " │ " ~ color('reset') ~ $_;
        }
    }
    @msg.push: "";
    return @msg.join("\n");
}
