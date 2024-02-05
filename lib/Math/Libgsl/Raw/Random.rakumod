use v6;

unit module Math::Libgsl::Raw::Random:ver<0.1.0>:auth<zef:FRITH>;

use NativeCall;

constant GSLHELPER  = %?RESOURCES<libraries/gslhelper>;

sub LIB {
  run('/sbin/ldconfig', '-p', :chomp, :out)
    .out
    .slurp(:close)
    .split("\n")
    .grep(/^ \s+ libgsl\.so\. \d+ /)
    .sort
    .head
    .comb(/\S+/)
    .head;
}

class gsl_rng_type is repr('CStruct') is export {
  has Str             $.name;
  has uint64          $.max;
  has uint64          $.min;
  has size_t          $.size;
  has Pointer[void]   $set;
  has Pointer[uint64] $get;
  has Pointer[num64]  $get_double;
}

class gsl_rng is repr('CStruct') is export {
  has gsl_rng_type    $.type;
  has Pointer[void]   $.state;
}

our $gsl_rng_default_seed is export = cglobal(&LIB, 'gsl_rng_default_seed', uint64);

# Random number generator initialization
sub mgsl_rng_setup(int32 $type --> gsl_rng) is native(GSLHELPER) is export { * }
sub gsl_rng_set(gsl_rng $r, uint64 $s) is native(&LIB) is export { * }
sub gsl_rng_free(gsl_rng $r) is native(&LIB) is export { * }
# Sampling from a random number generator
sub gsl_rng_get(gsl_rng $r --> uint64) is native(&LIB) is export { * }
sub gsl_rng_uniform(gsl_rng $r --> num64) is native(&LIB) is export { * }
sub gsl_rng_uniform_pos(gsl_rng $r --> num64) is native(&LIB) is export { * }
sub gsl_rng_uniform_int(gsl_rng $r, uint64 $n --> uint64) is native(&LIB) is export { * }
# Auxiliary random number generator functions
sub gsl_rng_name(gsl_rng $r --> Str) is native(&LIB) is export { * }
sub gsl_rng_max(gsl_rng $r --> uint64) is native(&LIB) is export { * }
sub gsl_rng_min(gsl_rng $r --> uint64) is native(&LIB) is export { * }
sub gsl_rng_state(gsl_rng $r --> Pointer[void]) is native(&LIB) is export { * }
sub gsl_rng_size(gsl_rng $r --> size_t) is native(&LIB) is export { * }
# Copying random number generator state
sub gsl_rng_memcpy(gsl_rng $dest, gsl_rng $src --> int32) is native(&LIB) is export { * }
sub gsl_rng_clone(gsl_rng $r --> gsl_rng) is native(&LIB) is export { * }
# Reading and writing random number generator state
sub mgsl_rng_fwrite(Str $filename, gsl_rng $r --> int32) is native(GSLHELPER) is export { * }
sub mgsl_rng_fread(Str $filename, gsl_rng $r --> int32) is native(GSLHELPER) is export { * }
