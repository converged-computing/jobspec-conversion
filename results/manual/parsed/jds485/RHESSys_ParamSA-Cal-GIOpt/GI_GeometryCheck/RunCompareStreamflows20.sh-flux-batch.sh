#!/bin/bash
#FLUX: --job-name=blue-avocado-2454
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load gcc/7.1.0 openmpi/3.1.4 R/3.5.3
Rscript /sfs/lustre/bahamut/scratch/js4yd/GI_RandomSeedEval910/CompareGIStreamflows.R '30' '/scratch/js4yd/GI_RandomSeedEval910/' 'RHESSys_Baisman30m_g74' '100' '2004-10-01' '1' '20'
