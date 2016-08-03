package Net::Microsoft::CognitiveServices::Face::Person;
use strict;
use warnings;
use base 'Net::Microsoft::CognitiveServices::Face::Base';

sub path {'/face/v1.0'};

sub _add_face_request {
    my ($self, $person_group_id, $person_id, $image_url, %param) = @_;
    $self->build_request(POST => ["persongroups/$person_group_id/persons/$person_id/persistedFaces", %param], 
        undef, {url => $image_url}
    );
}

sub add_face {
    my ($self, $person_group_id, $person_id, $image_url, %param) = @_;
    my $req = $self->_add_face_request($person_group_id, $person_id, $image_url, %param);
    $self->request($req);
}

sub _create_request {
    my ($self, $person_group_id, %param) = @_;
    $self->build_request(POST => ["persongroups/$person_group_id/persons"], undef, {%param});
}

sub create {
    my ($self, $person_group_id, %param) = @_;
    my $req = $self->_create_request($person_group_id, %param);
    $self->request($req);
}

1;