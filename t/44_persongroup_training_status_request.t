use strict;
use warnings;
use Test::More;
use Net::Azure::CognitiveServices::Face;

Net::Azure::CognitiveServices::Face->access_key('MYSECRET');
my $pg = Net::Azure::CognitiveServices::Face->PersonGroup;
isa_ok $pg, 'Net::Azure::CognitiveServices::Face::PersonGroup';
can_ok $pg, qw/_training_status_request/;

my $req = $pg->_training_status_request("machida_pm");

isa_ok $req, 'ARRAY';
is $req->[1], "https://westus.api.cognitive.microsoft.com/face/v1.0/persongroups/machida_pm/training";
is $req->[0], 'GET';
is $req->[2]{headers}{'Content-Type'}, 'application/json';
is $req->[2]{headers}{'Ocp-Apim-Subscription-Key'}, 'MYSECRET';

done_testing;