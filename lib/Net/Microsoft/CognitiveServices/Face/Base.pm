package Net::Microsoft::CognitiveServices::Face::Base;
use strict;
use warnings;
use Class::Accessor::Lite (
    new => 1,
    ro  => [qw[access_key endpoint]],
);
use LWP::UserAgent;
use JSON;
use Carp;
use URI;
use HTTP::Request;

sub path {''};

sub uri {
    my ($self, $path, %query) = @_;
    my $uri = URI->new($self->endpoint);
    $uri->path($path ? join('/', $self->path, $path) : $self->path);
    if (keys %query) {
        $uri->query_form(%query);
    }
    $uri;
}

sub json {
    my $self = shift;
    $self->{json} ||= JSON->new->utf8(1);
    $self->{json};
}

sub agent {
    my $self = shift;
    $self->{agent} ||= LWP::UserAgent->new(agent => __PACKAGE__, timeout => 60);
    $self->{agent};
}

sub request {
    my ($self, $req) = @_;
    my $res = $self->agent->request($req);
    my $body = $self->json->decode($res->content);
    if (!$res->is_success) {
        croak($body->{error}{message});
    }
    $body;
}

sub build_headers {
    my ($self, @headers) = @_;
    (
        "Content-Type"              => "application/json", 
        "Ocp-Apim-Subscription-Key" => $self->access_key,
        @headers, 
    );
}

sub build_request {
    my ($self, $method, $uri_param, $header, $hash) = @_;
    my $uri  = $self->uri(@$uri_param);
    my $body = $hash ? $self->json->encode($hash) : undef;
    my @headers = $self->build_headers(defined $header ? @$header : ());
    HTTP::Request->new($method => $uri, [@headers], $body);
}

1;