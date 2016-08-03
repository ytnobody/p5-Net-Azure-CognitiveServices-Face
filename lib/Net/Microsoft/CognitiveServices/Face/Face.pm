package Net::Microsoft::CognitiveServices::Face::Face;
use strict;
use warnings;
use base 'Net::Microsoft::CognitiveServices::Face::Base';

sub path {'/face/v1.0'};

sub _detect_request {
    my ($self, $image_url, %param) = @_;
    my %query = (
        returnFaceId         => defined $param{returnFaceId}         ? $param{returnFaceId} : 'true',
        returnFaceLandmarks  => defined $param{returnFaceLandmarks}  ? $param{returnFaceLandmarks} : 'false',
        returnFaceAttributes => defined $param{returnFaceAttributes} ? join(',', @{$param{returnFaceAttributes}}) : '',
    );
    $self->build_request(POST => ['detect', %query], undef, {url => $image_url});
}

sub detect {
    my ($self, $image_url, %param) = @_;
    my $req = $self->_detect_request($image_url, %param);
    $self->request($req);
}

1;