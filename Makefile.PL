use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'CommunityBuilder',
    AUTHOR              => 'Naveed Massjouni<naveedm9@gmail.com>',
    VERSION_FROM        => 'lib/CommunityBuilder.pm',
    LICENSE             => 'perl',
    PREREQ_PM => {
        'Test::More' => 0,
        'YAML'       => 0,
        'Dancer'     => 1.3095,
    },
);
