use strict;
use warnings;
use Test::More;
use Net::Microsoft::CognitiveServices::Face;

Net::Microsoft::CognitiveServices::Face->access_key('MYSECRET');
my $person = Net::Microsoft::CognitiveServices::Face->Person;
isa_ok $person, 'Net::Microsoft::CognitiveServices::Face::Person';
can_ok $person, qw/_delete_face_request/;

my $req = $person->_delete_face_request("machida_pm", 'ytnobody', 'ossan');

isa_ok $req, 'HTTP::Request';
is $req->uri, "https://api.projectoxford.ai/face/v1.0/persongroups/machida_pm/persons/ytnobody/persistedFaces/ossan";
is $req->method, 'DELETE';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';

done_testing;