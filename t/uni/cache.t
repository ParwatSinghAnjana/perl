BEGIN {
    chdir 't' if -d 't';
    @INC = qw(../lib .);
    require "test.pl";
}

plan tests => 2;

my $count = 0;
unshift @INC, sub {
       # XXX Kludge requires exact path, which might change
       $count++ if $_[1] eq 'unicore/lib/Sc/Hira.pl';
};

my $s = 'foo';

$s =~ m/[\p{Hiragana}]/;
$s =~ m/[\p{Hiragana}]/;
$s =~ m/[\p{Hiragana}]/;
$s =~ m/[\p{Hiragana}]/;

is($count, 1, "Swatch hash caching kept us from reloading swatch hash.");


# RT#75898
is(eval { utf8::upgrade($_ = " "); index $_, " ", 72 }, -1, "UTF-8 cache handles offset beyond the end of the string");

