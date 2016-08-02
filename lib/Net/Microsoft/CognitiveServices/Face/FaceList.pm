package Net::Microsoft::CognitiveServices::Face::FaceList;
use strict;
use warnings;
use base 'Net::Microsoft::CognitiveServices::Face::Base';

sub path {'/face/v1.0/facelists'};

sub _create_request {
    my ($self, $face_list_id, %param) = @_;
    my $body = {
        name     => $param{name}     || "$face_list_id", 
        userData => $param{userData} || "$face_list_id",
    };
    $self->build_request(PUT => [$face_list_id], undef, $body);
}

sub create {
    my ($self, $face_list_id, %param) = @_;
    my $req = $self->_create_request($face_list_id, %param);
    $self->request($req);
}

sub _add_request {
    my ($self, $face_list_id, $image_url, %param) = @_;
    $self->build_request(POST => ["$face_list_id/persistedFaces", %param], undef, {url => $image_url}); 
}

sub add {
    my ($self, $face_list_id, $image_url, %param) = @_;
    my $req = $self->_add_request($face_list_id, $image_url, %param);
    $self->request($req);
}

1;