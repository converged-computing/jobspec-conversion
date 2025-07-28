#!/bin/bash
#FLUX: --job-name=TF1
#FLUX: -c=16
#FLUX: -t=7140
#FLUX: --urgency=16

module purge
module load matlab/R2023a
matlab -nodisplay -nosplash -r  "align_long_short('/scratch/gpfs/ddenberg/231231/231231_st7/Ch0long_nanog', '/scratch/gpfs/ddenberg/231231/231231_st7/Ch0long_nanog_centers', '/scratch/gpfs/ddenberg/231231/231231_st7/Ch0short_gata6', '/scratch/gpfs/ddenberg/231231/231231_st7/Ch0short_gata6_centers', '/scratch/gpfs/ddenberg/231231/231231_st7/LS_align', [80:150], 16)"
