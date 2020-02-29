#!/usr/bin/env raku

use lib 'lib';
use Math::Libgsl::Random;

my Math::Libgsl::Random $r .= new;
$r.get-uniform.say for ^10;
