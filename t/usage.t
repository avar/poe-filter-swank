use strict;
use Test::More tests => 2;
use POE::Filter::Swank;

my $swank = POE::Filter::Swank->new;

is_deeply($swank->get(["000009greetings"]), [ 'greetings' ]);
is_deeply($swank->put(["greetings"]), [ '000009', 'greetings' ]);

