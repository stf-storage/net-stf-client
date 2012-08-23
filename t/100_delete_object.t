use strict;
use Test::More;
use_ok "Net::STF::Client";

{
    my $client = Net::STF::Client->new(
        username => "hoge",
        password => "fuga",
    );

    my $e;

    eval {
        $client->delete_object( "http://stf.example.com/foo" );
    };
    $e = $@;
    ok $e, "invalid URL (only bucket name + no trailing slash) should die";
    like $e, qr/Invalid URL/;

    eval {
        $client->delete_object( "http://stf.example.com/foo/" );
    };
    $e = $@;
    ok $e, "invalid URL (only bucket name) should die";
    like $e, qr/Invalid URL/;

    eval {
        $client->delete_object( "http://stf.example.com/foo//" );
    };
    $e = $@;
    ok $e, "invalid URL (only bucket name + multiple trailing slashes) should die";
    like $e, qr/Invalid URL/;

    eval {
        $client->delete_object( "http://stf.example.com/foo/." );
    };
    $e = $@;
    ok $e, "invalid URL (trailing period) should die";
    like $e, qr/Invalid URL/;

    eval {
        $client->delete_object( "http://stf.example.com/foo/.." );
    };
    $e = $@;
    ok $e, "invalid URL (multiple trailing period) should die";
    like $e, qr/Invalid URL/;

    eval {
        $client->delete_object( "http://stf.example.com/foo//." );
    };
    $e = $@;
    ok $e, "invalid URL (trailing period + multiple trailing slashes) should die";
    like $e, qr/Invalid URL/;

    eval {
        $client->delete_object( "http://stf.example.com/foo//.." );
    };
    $e = $@;
    ok $e, "invalid URL (multiple trailing period + multiple trailing slashes) should die";
    like $e, qr/Invalid URL/;
    
}

done_testing;
