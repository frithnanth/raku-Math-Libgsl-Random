#include <stdio.h>
#include <stdlib.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_errno.h>

/* Setup */
gsl_rng *mgsl_rng_setup(int type)
{
  const gsl_rng_type *types[] = {
    gsl_rng_borosh13, gsl_rng_coveyou, gsl_rng_cmrg, gsl_rng_fishman18, gsl_rng_fishman20,
    gsl_rng_fishman2x, gsl_rng_gfsr4, gsl_rng_knuthran, gsl_rng_knuthran2, gsl_rng_knuthran2002,
    gsl_rng_lecuyer21, gsl_rng_minstd, gsl_rng_mrg, gsl_rng_mt19937, gsl_rng_mt19937_1999,
    gsl_rng_mt19937_1998, gsl_rng_r250, gsl_rng_ran0, gsl_rng_ran1, gsl_rng_ran2, gsl_rng_ran3,
    gsl_rng_rand, gsl_rng_rand48, gsl_rng_random128_bsd, gsl_rng_random128_glibc2,
    gsl_rng_random128_libc5, gsl_rng_random256_bsd, gsl_rng_random256_glibc2,
    gsl_rng_random256_libc5, gsl_rng_random32_bsd, gsl_rng_random32_glibc2,
    gsl_rng_random32_libc5, gsl_rng_random64_bsd, gsl_rng_random64_glibc2,
    gsl_rng_random64_libc5, gsl_rng_random8_bsd, gsl_rng_random8_glibc2, gsl_rng_random8_libc5,
    gsl_rng_random_bsd, gsl_rng_random_glibc2, gsl_rng_random_libc5, gsl_rng_randu,
    gsl_rng_ranf, gsl_rng_ranlux, gsl_rng_ranlux389, gsl_rng_ranlxd1, gsl_rng_ranlxd2,
    gsl_rng_ranlxs0, gsl_rng_ranlxs1, gsl_rng_ranlxs2, gsl_rng_ranmar, gsl_rng_slatec,
    gsl_rng_taus, gsl_rng_taus2, gsl_rng_taus113, gsl_rng_transputer, gsl_rng_tt800,
    gsl_rng_uni, gsl_rng_uni32, gsl_rng_vax, gsl_rng_waterman14, gsl_rng_zuf, gsl_rng_default
  };
  const gsl_rng_type *T;
  gsl_rng *r;
  gsl_rng_env_setup();
  T = types[type];
  r = gsl_rng_alloc(T);
  return r;
}

/* RNG IO*/
int mgsl_rng_fwrite(const char *filename, const gsl_rng *r)
{
  FILE *fp;
  if((fp = fopen(filename, "w")) == NULL) return GSL_EFAILED;
  if(gsl_rng_fwrite(fp, r) != GSL_SUCCESS) return GSL_EFAILED;
  fclose(fp);
  return GSL_SUCCESS;
}

int mgsl_rng_fread(const char *filename, gsl_rng *r)
{
  FILE *fp;
  if((fp = fopen(filename, "r")) == NULL) return GSL_EFAILED;
  if(gsl_rng_fread(fp, r) != GSL_SUCCESS) return GSL_EFAILED;
  fclose(fp);
  return GSL_SUCCESS;
}
