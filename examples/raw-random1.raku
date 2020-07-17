#!/usr/bin/env raku

# See "GNU Scientific Library" manual Chapter 18 Random Number Generation, Paragraph 18.6

use lib 'lib';
use Math::Libgsl::Raw::Random;
use Math::Libgsl::Constants;

my gsl_rng $r = mgsl_rng_setup(DEFAULT);
say 'generator type: ' ~ gsl_rng_name($r);
say 'seed: ' ~ $gsl_rng_default_seed;
say 'first value: ' ~ gsl_rng_get($r);
gsl_rng_free($r);
