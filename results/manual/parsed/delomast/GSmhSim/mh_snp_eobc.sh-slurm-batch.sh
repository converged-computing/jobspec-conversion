#!/bin/bash
#SBATCH --output=arrayScrm_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60G
#SBATCH --time=4-23:00:00
#SBATCH --partition=medium
#SBATCH --array=1-200%75

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
