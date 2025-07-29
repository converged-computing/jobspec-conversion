#!/bin/bash
#SBATCH --job-name=deepcsr
#SBATCH --account=PSYC0002
#SBATCH --output=/data/users2/washbee/deepcsr/jobs/out%A.out
#SBATCH --error=/data/users2/washbee/deepcsr/jobs/error%A.err
#SBATCH --mail-user=washbee1@student.gsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=40g
#SBATCH --time=3-00:00:00
#SBATCH --partition=qTRDGPUH
#SBATCH --nodelist=trendsdgx003.rs.gsu.edu

sleep 5s
singularity exec --nv --bind /data:/data/,/home:/home/,/home/users/washbee1/projects/deepcsr:/deepcsr/,/data/users2/washbee/outdir:/subj /data/users2/washbee/containers/deepcsr.sif /deepcsr/singularity/train.sh &
wait
sleep 10s
