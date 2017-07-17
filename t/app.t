use strict;
use warnings;
use FindBin;
use Plack::Test;
use HTTP::Request::Common;
use Test::More;
use JSON;

my $app = do("$FindBin::RealBin/../app.psgi");
my $plack_test = Plack::Test->create($app);
my $response;

# Default responses
$response = $plack_test->request(GET '/');
ok($response->content =~ /Inspire Candidate Exercise/, 'received default response');
$response = $plack_test->request(GET '/anything/else');
ok($response->content =~ /Inspire Candidate Exercise/, 'received default response again');

# Create Darth the Wombat
my $darth = { name=>'Darth', dob=>'2015-05-04' };
$response = $plack_test->request(POST "/wombats", $darth);
is($response->code, 201, 'HTTP Created response');
my $new_wombat = decode_json($response->content);
is(ref $new_wombat, 'HASH', 'Decoded web Darth');
ok($new_wombat->{id} =~ /^\d+$/, 'New ID created');
is($new_wombat->{name}, $darth->{name}, 'Wombat is named Darth');
is($new_wombat->{dob}, $darth->{dob}, 'Wombat was born on May the 4th');

# List wombats
$response = $plack_test->request(GET '/wombats');
is($response->code, 200, 'Wombat listing');
is($response->header('content-type'), 'application/json', 'wombat listing claims to be json');
my $wombat_list = decode_json($response->content);
is(ref $wombat_list, 'ARRAY', 'Decoded a list of wombats');
is_deeply($wombat_list->[-1], $new_wombat, 'List ends with Darth');

# Invalid action
$response = $plack_test->request(PUT '/wombats');
is($response->code, 405, 'PUT method not allowed');

done_testing();
