#!/usr/bin/env raku

# See "GNU Scientific Library" manual Chapter 18 Random Number Generation, Paragraph 18.13

use lib 'lib';
use Math::Libgsl::Raw::Random;
use Math::Libgsl::Constants;

my gsl_rng $r = mgsl_rng_setup(DEFAULT);
printf "%.5f\n", gsl_rng_uniform($r) for ^10;
gsl_rng_free($r);
