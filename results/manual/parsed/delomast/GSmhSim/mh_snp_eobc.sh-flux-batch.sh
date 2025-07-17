#!/bin/bash
#FLUX: --job-name=reclusive-snack-5689
#FLUX: --queue=medium
#FLUX: -t=428400
#FLUX: --urgency=16

echo "My SLURM_JOB_ID: " $SLURM_JOB_ID
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
module load r/4.3.0
module load gcc # make some c++ libraries available that R packages rely on
if [ ! -f randSeeds.txt ]; then
    echo "randSeeds.txt does not exist."
	exit 1
fi
x=$(cat randSeeds.txt | sed -n ${SLURM_ARRAY_TASK_ID}p)
echo "My random seed is: " $x
mkdir /90daydata/oyster_gs_sim/temp"$SLURM_ARRAY_TASK_ID"
Rscript mh_snp_comparison_sim.R $x $SLURM_ARRAY_TASK_ID /90daydata/oyster_gs_sim/ ../seq_data_mh/allPhased_eobc.vcf
rm -r /90daydata/oyster_gs_sim/temp"$SLURM_ARRAY_TASK_ID"
echo "Done with simulation"
