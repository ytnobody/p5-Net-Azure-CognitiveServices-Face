requires 'perl', '5.008001';
requires 'Class::Accessor::Lite';
requires 'LWP::UserAgent';
requires 'JSON';
requires 'Carp';
requires 'URI';
requires 'HTTP::Request';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

