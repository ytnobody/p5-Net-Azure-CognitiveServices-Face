use strict;
use warnings;
use Test::More;
use Net::Microsoft::CognitiveServices::Face;

Net::Microsoft::CognitiveServices::Face->access_key('MYSECRET');
my $face = Net::Microsoft::CognitiveServices::Face->Face;
isa_ok $face, 'Net::Microsoft::CognitiveServices::Face::Face';
can_ok $face, qw/_identify_request/;

my $req = $face->_identify_request(
    personGroupId       => "sample_group",
    faceIds             => ["foo", "bar"],
    confidenceThreshold => 0.6,
);

isa_ok $req, 'HTTP::Request';
is $req->uri, 'https://api.projectoxford.ai/face/v1.0/identify';
is $req->method, 'POST';
is $req->header('Content-Type'), 'application/json';
is $req->header('Ocp-Apim-Subscription-Key'), 'MYSECRET';
like $req->content, qr|"faceIds":\["foo","bar"\]|;
like $req->content, qr|"personGroupId":"sample_group"|;
like $req->content, qr|"confidenceThreshold":0.6|;

done_testing;