package Net::Microsoft::CognitiveServices::Face::PersonGroup;
use strict;
use warnings;
use base 'Net::Microsoft::CognitiveServices::Face::Base';

sub path {'/face/v1.0/persongroups'};

sub _create_request {
    my ($self, $person_group_id, %param) = @_;
    $self->build_request(PUT => [$person_group_id], undef, {%param});
}

sub create {
    my ($self, $person_group_id, %param) = @_;
    my $req = $self->_create_request($person_group_id, %param);
    $self->request($req);
}

sub _delete_request {
    my ($self, $person_group_id) = @_;
    $self->build_request(DELETE => [$person_group_id]);
}

sub delete {
    my ($self, $person_group_id) = @_;
    my $req = $self->_delete_request($person_group_id);
    $self->request($req); 
}

sub _get_request {
    my ($self, $person_group_id) = @_;
    $self->build_request(GET => [$person_group_id]);
}

sub get {
    my ($self, $person_group_id) = @_;
    my $req = $self->_get_request($person_group_id);
    $self->request($req);
}

sub _training_status_request {
    my ($self, $person_group_id) = @_;
    $self->build_request(GET => ["$person_group_id/training"]);
}

sub training_status {
    my ($self, $person_group_id) = @_;
    my $req = $self->_training_status_request($person_group_id);
    $self->request($req);
}

sub _list_request {
    my ($self, %param) = @_;
    $self->build_request(GET => [undef, %param]);
}

sub list {
    my ($self, %param) = @_;
    my $req = $self->_list_request(%param);
    $self->request($req);
}

sub _train_request {
    my ($self, $person_group_id) = @_;
    $self->build_request(POST => ["$person_group_id/train"], undef, {body => ''});
}

sub train {
    my ($self, $person_group_id) = @_;
    my $req = $self->_train_request($person_group_id);
    $self->request($req);
}

sub _update_request {
    my ($self, $person_group_id, %param) = @_;
    $self->build_request(PATCH => [$person_group_id], undef, {%param});
}

sub update {
    my ($self, $person_group_id, %param) = @_;
    my $req = $self->_update_request($person_group_id, %param);
    $self->request($req);
}

1;