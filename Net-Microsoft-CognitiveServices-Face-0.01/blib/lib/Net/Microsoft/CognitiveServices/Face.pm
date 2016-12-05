package Net::Microsoft::CognitiveServices::Face;
use 5.008001;
use strict;
use warnings;
use Net::Microsoft::CognitiveServices::Face::Face;
use Net::Microsoft::CognitiveServices::Face::FaceList;
use Net::Microsoft::CognitiveServices::Face::Person;
use Net::Microsoft::CognitiveServices::Face::PersonGroup;

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

Net::Microsoft::CognitiveServices::Face - A wrapper class for Face API of Microsoft Cognitive Services

=head1 SYNOPSIS

    use Net::Microsoft::CognitiveServices::Face;
    Net::Microsoft::CognitiveServices::Face->access_key('YOUR_ACCESS_KEY');

    ### Face - Detect
    my $face_api = Net::Microsoft::CognitiveServices::Face->Face;
    my $result = $face_api->detect(
        "http://example.com/photo.jpg", 
        returnFaceAttributes => ['age', 'gender'],
    );
    printf "age: %d, gender: %d\n", $result->[0]{faceAttributes}{age}, $result->[0]{faceAttributes}{gender};
    
    ### Person - List Persons in a PersonGroup
    my $person_api = Net::Microsoft::CognitiveServices::Face->Person;
    $result = $person_api->list('my_person_group');
    for my $person (@$result) {
        printf "name: %s, personId: %s\n", $person->{name}, $person->{personId};
    }


=head1 DESCRIPTION

Net::Microsoft::CognitiveServices::Face provides following subclasses.

=over 4

=item Net::Microsoft::CognitiveServices::Face::Face

=item Net::Microsoft::CognitiveServices::Face::FaceList

=item Net::Microsoft::CognitiveServices::Face::Person

=item Net::Microsoft::CognitiveServices::Face::PersonGroup

=back 

Please see L<https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236> for more information. 

=head1 METHODS

=head2 access_key

Set the access key for accessing to Microsoft Cognitive Services APIs

=head2 Face

Returns an instance of Net::Microsoft::CognitiveServices::Face::Face

=head2 FaceList

Returns an instance of Net::Microsoft::CognitiveServices::Face::FaceList

=head2 Person

Returns an instance of Net::Microsoft::CognitiveServices::Face::Person

=head2 PersonGroup

Returns an instance of Net::Microsoft::CognitiveServices::Face::PersonGroup

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

