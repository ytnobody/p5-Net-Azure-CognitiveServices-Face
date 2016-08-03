use strict;
use warnings;
use Test::More;
use Net::Microsoft::CognitiveServices::Face;

Net::Microsoft::CognitiveServices::Face->access_key('MYSECRET');
my $person = Net::Microsoft::CognitiveServices::Face->Person;
isa_ok $person, 'Net::Microsoft::CognitiveServices::Face::Person';
can_ok $person, qw/_update_request/;

my $req = $person->_update_request("machida_pm", "ytnobody", name => "Satoshi Azuma", userData => "PAUSE=YTURTLE");

isa_ok $req, 'HTTP::Request';
is $req->uri, "https://api.projectoxford.ai/face/v1.0/persongroups/machida_pm/persons/ytnobody";
is $req->method, 'PATCH';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';
like $req->content, qr|"name":"Satoshi Azuma"|;
like $req->content, qr|"userData":"PAUSE=YTURTLE"|;

done_testing;