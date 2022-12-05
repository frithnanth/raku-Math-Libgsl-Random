[![Actions Status](https://github.com/frithnanth/raku-Math-Libgsl-Random/workflows/test/badge.svg)](https://github.com/frithnanth/raku-Math-Libgsl-Random/actions)

NAME
====

Math::Libgsl::Random - An interface to libgsl, the Gnu Scientific Library - Random Number Generation.

SYNOPSIS
========

```raku
use Math::Libgsl::Random;

my Math::Libgsl::Random $r .= new;
$r.get-uniform.say for ^10;
```

DESCRIPTION
===========

Math::Libgsl::Random is an interface to the Random Number Generation routines of libgsl, the Gnu Scientific Library.

### new(Int :$type?)

The constructor allows one optional parameter, the random number generator type. One can find an enum listing all the generator types in the Math::Libgsl::Constants module.

### get(--> Int)

Returns the next random number as an Int.

### get-uniform(--> Num)

Returns the next random number as a Num in the interval [0, 1).

### get-uniform-pos(--> Num)

Returns the next random number as a Num in the interval (0, 1).

### get-uniform-int(Int $n --> Int)

This method returns an Int in the range [0, n - 1].

### seed(Int $seed)

This method initializes the random number generator. This method returns **self**, so it can be concatenated to the **.new()** method:

```raku
my $r = Math::Libgsl::Random.new.seed(42);
$r.get.say;

# or even

Math::Libgsl::Random.new.seed(42).get.say;
```

### name(--> Str)

This method returns the name of the current random number generator.

### min(--> Int)

This method returns the minimum value the current random number generator can generate.

### max(--> Int)

This method returns the maximum value the current random number generator can generate.

### copy(Math::Libgsl::Random $src)

This method copies the source generator **$src** into the current one and returns the current object, so it can be concatenated. The generator state is also copied, so the source and destination generators deliver the same values.

### clone(--> Math::Libgsl::Random)

This method clones the current object and returns a new object. The generator state is also cloned, so the source and destination generators deliver the same values.

```raku
my $r = Math::Libgsl::Random.new;
my $clone = $r.clone;
```

### write(Str $filename!)

Writes the generator to a file in binary form. This method can be chained.

### read(Str $filename!)

Reads the generator from a file in binary form. This method can be chained.

C Library Documentation
=======================

For more details on libgsl see [https://www.gnu.org/software/gsl/](https://www.gnu.org/software/gsl/). The excellent C Library manual is available here [https://www.gnu.org/software/gsl/doc/html/index.html](https://www.gnu.org/software/gsl/doc/html/index.html), or here [https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf](https://www.gnu.org/software/gsl/doc/latex/gsl-ref.pdf) in PDF format.

Prerequisites
=============

This module requires the libgsl library to be installed. Please follow the instructions below based on your platform:

Debian Linux and Ubuntu 20.04+
------------------------------

    sudo apt install libgsl23 libgsl-dev libgslcblas0

That command will install libgslcblas0 as well, since it's used by the GSL.

Ubuntu 18.04
------------

libgsl23 and libgslcblas0 have a missing symbol on Ubuntu 18.04. I solved the issue installing the Debian Buster version of those three libraries:

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgslcblas0_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl23_2.5+dfsg-6_amd64.deb)

  * [http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb](http://http.us.debian.org/debian/pool/main/g/gsl/libgsl-dev_2.5+dfsg-6_amd64.deb)

Installation
============

To install it using zef (a module management tool):

    $ zef install Math::Libgsl::Random

AUTHOR
======

Fernando Santagata <nando.santagata@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

