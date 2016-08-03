# NAME

Net::Microsoft::CognitiveServices::Face - A wrapper class for Face API of Microsoft Cognitive Services

# SYNOPSIS

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

# DESCRIPTION

Net::Microsoft::CognitiveServices::Face provides following subclasses.

- Net::Microsoft::CognitiveServices::Face::Face
- Net::Microsoft::CognitiveServices::Face::FaceList
- Net::Microsoft::CognitiveServices::Face::Person
- Net::Microsoft::CognitiveServices::Face::PersonGroup

Please see \[API Reference of Face API V1.0\](https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236) for more information. 

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>
