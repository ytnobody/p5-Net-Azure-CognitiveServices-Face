package Net::Microsoft::CognitiveServices::Face;
use 5.008001;
use strict;
use warnings;
use Net::Microsoft::CognitiveServices::Face::Face;
use Net::Microsoft::CognitiveServices::Face::FaceList;
use Net::Microsoft::CognitiveServices::Face::Person;

our $VERSION  = "0.01";
our $AUTOLOAD;
our $INSTANCES = {};
our $ACCESS_KEY;
our $ENDPOINT = 'https://api.projectoxford.ai';

sub access_key {
    my ($class, $key) = @_;
    if ($key) {
        $ACCESS_KEY ||= $key;
    }
    return $ACCESS_KEY;
}

sub AUTOLOAD {
    my $class = shift;
    my $subclass = $AUTOLOAD;
    $INSTANCES->{$subclass} ||= $subclass->new(access_key => $ACCESS_KEY, endpoint => $ENDPOINT);
    $INSTANCES->{$subclass}; 
}

1;
__END__

=encoding utf-8

=head1 NAME

Net::Microsoft::CognitiveServices::Face - It's new $module

=head1 SYNOPSIS

    use Net::Microsoft::CognitiveServices::Face;

=head1 DESCRIPTION

Net::Microsoft::CognitiveServices::Face is ...

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

