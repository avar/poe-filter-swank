use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'POE::Filter::Swank',
    AUTHOR        => 'Ævar Arnfjörð Bjarmason <avar@cpan.org>',
    ABSTRACT_FROM => 'lib/POE/Filter/Swank.pm',
    VERSION_FROM  => 'lib/POE/Filter/Swank.pm',
    LICENSE       => 'perl',
    PREREQ_PM     => {
        # Client.pm
        'POE'         => '0.9999',

        # t/
        'Test::More' => 0,
    },
);
