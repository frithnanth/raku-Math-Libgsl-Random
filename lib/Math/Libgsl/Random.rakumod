use v6.c;

unit class Math::Libgsl::Random:ver<0.0.3>:auth<zef:FRITH>;

use Math::Libgsl::Raw::Random;
use Math::Libgsl::Exception;
use Math::Libgsl::Constants;
use NativeCall;

has gsl_rng $.r;

submethod BUILD(Int :$type?, gsl_rng :$r?) {
  with $r {
    $!r = $r
  } else {
    $!r = mgsl_rng_setup($type // DEFAULT)
  }
}
submethod DESTROY { gsl_rng_free($!r) }

method get(--> Int) { gsl_rng_get($!r) }
method get-uniform(--> Num) { gsl_rng_uniform($!r) }
method get-uniform-pos(--> Num) { gsl_rng_uniform_pos($!r) }
method get-uniform-int(Int $n --> Int) { gsl_rng_uniform_int($!r, $n) }
method seed(Int $seed) { gsl_rng_set($!r, $seed); self }

method name(--> Str) { gsl_rng_name($!r) }
method min(--> Int) { gsl_rng_min($!r) }
method max(--> Int) { gsl_rng_max($!r) }

method copy(Math::Libgsl::Random $src) {
  my $ret = gsl_rng_memcpy($!r, $src.r);
  fail X::Libgsl.new: errno => $ret, error => "Can't copy the generator" if $ret ≠ GSL_SUCCESS;
  self
}
method clone(--> Math::Libgsl::Random) { Math::Libgsl::Random.new: r => gsl_rng_clone($!r) }

method write(Str $filename!) {
  my $ret = mgsl_rng_fwrite($filename, $!r);
  fail X::Libgsl.new: errno => $ret, error => "Can't write the generator" if $ret ≠ GSL_SUCCESS;
  self
}
method read(Str $filename!) {
  my $ret = mgsl_rng_fread($filename, $!r);
  fail X::Libgsl.new: errno => $ret, error => "Can't read the generator" if $ret ≠ GSL_SUCCESS;
  self
}

=begin pod

[![Build Status](https://travis-ci.org/frithnanth/raku-Math-Libgsl-Random.svg?branch=master)](https://travis-ci.org/frithnanth/raku-Math-Libgsl-Random)

=head1 NAME

Math::Libgsl::Random - An interface to libgsl, the Gnu Scientific Library - Random Number Generation.

=head1 SYNOPSIS

=begin code :lang<raku>

use Math::Libgsl::Random;

my Math::Libgsl::Random $r .= new;
$r.get-uniform.say for ^10;

=end code

=head1 DESCRIPTION

Math::Libgsl::Random is an interface to the Random Number Generation routines of libgsl, the Gnu Scientific Library.

=head3 new(Int :$type?)

The constructor allows one optional parameter, the random number generator type. One can find an enum listing all the generator types in the Math::Libgsl::Constants module.

=head3 get(--> Int)

Returns the next random number as an Int.

=head3 get-uniform(--> Num)

Returns the next random number as a Num in the interval [0, 1).

=head3 get-uniform-pos(--> Num)

Returns the next random number as a Num in the interval (0, 1).

=head3 get-uniform-int(Int $n --> Int)

This method returns an Int in the range [0, n - 1].

=head3 seed(Int $seed)

This method initializes the random number generator.
This method returns B<self>, so it can be concatenated to the B<.new()> method:

=begin code :lang<raku>

my $r = Math::Libgsl::Random.new.seed(42);
$r.get.say;

# or even

Math::Libgsl::Random.new.seed(42).get.say;

=end code

=head3 name(--> Str)

This method returns the name of the current random number generator.

=head3 min(--> Int)

This method returns the minimum value the current random number generator can generate.

=head3 max(--> Int)

This method returns the maximum value the current random number generator can generate.

=head3 copy(Math::Libgsl::Random $src)

This method copies the source generator B<$src> into the current one and returns the current object, so it can be concatenated.
The generator state is also copied, so the source and destination generators deliver the same values.

=head3 clone(--> Math::Libgsl::Random)

This method clones the current object and returns a new object.
The generator state is also cloned, so the source and destination generators deliver the same values.

=begin code :lang<raku>

my $r = Math::Libgsl::Random.new;
my $clone = $r.clone;

=end code

=head3 write(Str $filename!)

Writes the generator to a file in binary form.
This method can be chained.

=head3 read(Str $filename!)

Reads the generator from a file in binary form.
This method can be chained.

=head1 C Library Documentation

For more details on libgsl see L<https://www.gnu.org/software/gsl/>.
The excellent C Library manual is available here L<https://www.gnu.org/software/gsl/doc/html/index.html>, or here L<https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf> in PDF format.

=head1 Prerequisites

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

=head2 Debian Linux and Ubuntu 20.04+

=begin code
sudo apt install libgsl23 libgsl-dev libgslcblas0
=end code

That command will install libgslcblas0 as well, since it's used by the GSL.

=head2 Ubuntu 18.04

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04.
I solved the issue installing the Debian Buster version of those three libraries:

=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb>
=item L<http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb>

=head1 Installation

To install it using zef (a module management tool):

=begin code
$ zef install Math::Libgsl::Random
=end code

=head1 AUTHOR

Fernando Santagata <nando.santagata@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
