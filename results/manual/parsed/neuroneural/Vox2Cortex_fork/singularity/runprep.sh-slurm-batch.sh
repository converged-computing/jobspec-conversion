#!/bin/bash
#SBATCH --job-name=v2cprep
#SBATCH --account=psy53c17
#SBATCH --output=jobs/out%A.out
#SBATCH --error=jobs/error%A.err
#SBATCH --mail-user=washbee1@student.gsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=200g
#SBATCH --time=5-00:00:00
#SBATCH --partition=qTRDGPUH
#SBATCH --exclude=arctrdgn002,arctrddgx001

sleep 5s
module load singularity/3.10.2
singularity exec --nv --bind /data,/data/users2/washbee/speedrun/Vox2Cortex_fork/:/v2c,/data/users2/washbee/speedrun/v2c-data:/subj /data/users2/washbee/containers/speedrun/v2c_sr.sif /v2c/singularity/prep.sh &
wait
