use strict;
use warnings;
use Test::More;
use Net::Microsoft::CognitiveServices::Face;

Net::Microsoft::CognitiveServices::Face->access_key('MYSECRET');
my $pg = Net::Microsoft::CognitiveServices::Face->PersonGroup;
isa_ok $pg, 'Net::Microsoft::CognitiveServices::Face::PersonGroup';
can_ok $pg, qw/_training_status_request/;

my $req = $pg->_training_status_request("machida_pm");

isa_ok $req, 'HTTP::Request';
is $req->uri, "https://api.projectoxford.ai/face/v1.0/persongroups/machida_pm/training";
is $req->method, 'GET';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';

done_testing;