#!/bin/bash
#SBATCH --job-name=ssnet
#SBATCH --output=log_ssnet.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=1-00:00:00
#SBATCH --nodelist=pgpu01

CONTAINER=/cluster/kappa/90-days-archive/wongjiradlab/larbys/images/singularity-dllee-ssnet/singularity-dllee-ssnet-nvidia384.66.img
WORKDIR=/cluster/kappa/90-days-archive/wongjiradlab/grid_jobs/ssnet-tuftscluster-scripts
INPUTLISTDIR=${WORKDIR}/inputlists
JOBLIST=${WORKDIR}/rerunlist.txt
OUTDIR=/cluster/kappa/90-days-archive/wongjiradlab/larbys/data/comparison_samples/extbnb_wprecuts_reprocess/out_week10132017/ssnet_p02
module load singularity
python manage_tufts_gpu_jobs.py ${CONTAINER} ${WORKDIR}
