requires 'perl', '5.008001';
requires 'Class::Accessor::Lite';
requires 'JSON';
requires 'Carp';
requires 'URI';
requires 'HTTP::Tiny';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

