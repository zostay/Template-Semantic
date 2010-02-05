use strict;
use warnings;
use Test::More;

use Template::Semantic;
use XML::LibXML;

subtest 'default options' => sub {
    plan tests => 1;
    
    my $ts = Template::Semantic->new;
    
    eval {
        $ts->process(\'<root>&heart;</root>');
    };
    ok(not $@);
};

subtest 'libxml_options => (custom)' => sub {
    plan tests => 1;
    
    my $ts = Template::Semantic->new(
        libxml_options => {
            recover => 0,
        },
    );
    
    eval {
        $ts->process(\'<root>&heart;</root>');
    };
    like($@, qr/Entity 'heart' not defined/);
};

subtest 'parser => (custom)' => sub {
    plan tests => 1;
    
    my $ts = Template::Semantic->new(
        parser => do {
            my $parser = XML::LibXML->new;
            $parser->no_network(1);
            $parser->recover(0);
            $parser;
        },
    );
    
    eval {
        $ts->process(\'<root>&heart;</root>');
    };
    like($@, qr/Entity 'heart' not defined/);
};

done_testing;
