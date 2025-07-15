#!/bin/bash
#FLUX: --job-name=fat-leg-0264
#FLUX: --urgency=16

module load intel/16.0.3
ibrun /work/00410/huang/namd/build/2.12_skx/NAMD_2.12_Source/Linux-KNL-icc/namd2 chromat100-bench.namd &> log
