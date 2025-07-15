#!/bin/bash
#FLUX: --job-name=faux-salad-8873
#FLUX: -c=2
#FLUX: --queue=xnat
#FLUX: -t=3600
#FLUX: --urgency=16

if [ $# -ne 2 ];
    then echo "Please pass sub_prefix visit and step as command line arguments. E.g."
    echo "sbatch --array=101,103,105 srun_bids.sh SA V1"
    echo "Exiting."
    exit 1
fi
sub_prefix=$1       # Prefix of the subjects we're working on e.g. SA SB etc...
visit=$2
set --
module purge
module load Anaconda3/2020.11
source /hpc/shared/EasyBuild/apps/Anaconda3/2020.11/bin/activate
conda activate /hpc/users/urszula.gorska/.conda/envs/mne_meg01_clone
srun python P00_bids_conversion.py --sub ${sub_prefix}`printf "%03d" $SLURM_ARRAY_TASK_ID` --visit ${visit}
