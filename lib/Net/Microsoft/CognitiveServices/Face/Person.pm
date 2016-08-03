package Net::Microsoft::CognitiveServices::Face::Person;
use strict;
use warnings;
use base 'Net::Microsoft::CognitiveServices::Face::Base';

sub path {'/face/v1.0/persongroups'};

sub _add_face_request {
    my ($self, $person_group_id, $person_id, $image_url, %param) = @_;
    $self->build_request(POST => ["$person_group_id/persons/$person_id/persistedFaces", %param], 
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
    $self->build_request(POST => ["$person_group_id/persons"], undef, {%param});
}

sub create {
    my ($self, $person_group_id, %param) = @_;
    my $req = $self->_create_request($person_group_id, %param);
    $self->request($req);
}

sub _delete_request {
    my ($self, $person_group_id, $person_id) = @_;
    $self->build_request(DELETE => ["$person_group_id/persons/$person_id"]);
}

sub delete {
    my ($self, $person_group_id, $person_id) = @_;
    my $req = $self->_delete_request($person_group_id, $person_id);
    $self->request($req);
}

sub _delete_face_request {
    my ($self, $person_group_id, $person_id, $persisted_face_id) = @_;
    $self->build_request(DELETE => ["$person_group_id/persons/$person_id/persistedFaces/$persisted_face_id"]);
}

sub delete_face {
    my ($self, $person_group_id, $person_id, $persisted_face_id) = @_;
    my $req = $self->build_request($person_group_id, $person_id, $persisted_face_id);
    $self->request($req);
}

sub _get_request {
    my ($self, $person_group_id, $person_id) = @_;
    $self->build_request(GET => ["$person_group_id/persons/$person_id"]);
}

sub get {
    my ($self, $person_group_id, $person_id) = @_;
    my $req = $self->_get_request($person_group_id, $person_id);
    $self->request($req);
}

sub _get_face_request {
    my ($self, $person_group_id, $person_id, $persisted_face_id) = @_;
    $self->build_request(GET => ["$person_group_id/persons/$person_id/persistedFaces/$persisted_face_id"]);
}

sub get_face {
    my ($self, $person_group_id, $person_id, $persisted_face_id) = @_;
    my $req = $self->_get_face_request($person_group_id, $person_id, $persisted_face_id);
    $self->request($req);
}

sub _list_request {
    my ($self, $person_group_id) = @_;
    $self->build_request(GET => ["$person_group_id/persons"]);
}

sub list {
    my ($self, $person_group_id) = @_;
    my $req = $self->_list_request($person_group_id);
    $self->request($req);
}

1;