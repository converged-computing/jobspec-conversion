#!/bin/bash
#FLUX: --job-name=phat-despacito-3452
#FLUX: --exclusive
#FLUX: --priority=16

srun likwid-bench -s 10 -t load_avx512 -w S0:1GB:14
srun likwid-bench -s 10 -t copy_mem_avx512 -w S0:1GB:14
srun likwid-bench -s 10 -t stream_mem_avx512 -w S0:1GB:14
srun likwid-bench -s 10 -t store_mem_avx512 -w S0:1GB:14
