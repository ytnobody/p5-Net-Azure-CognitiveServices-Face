use strict;
use warnings;
use Test::More;
use Net::Microsoft::CognitiveServices::Face;

Net::Microsoft::CognitiveServices::Face->access_key('MYSECRET');
my $facelist = Net::Microsoft::CognitiveServices::Face->FaceList;
isa_ok $facelist, 'Net::Microsoft::CognitiveServices::Face::FaceList';
can_ok $facelist, qw/_flush_request/;

my $req = $facelist->_flush_request('my_facelist');
isa_ok $req, 'HTTP::Request';
is $req->uri, 'https://api.projectoxford.ai/face/v1.0/facelists/my_facelist/persistedFaces';
is $req->method, 'DELETE';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';

done_testing;