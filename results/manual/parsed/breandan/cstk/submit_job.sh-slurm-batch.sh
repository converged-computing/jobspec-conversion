#!/bin/bash
#SBATCH --account=def-jinguo
#SBATCH --output=/scratch/b/bengioy/breandan/slurm-%j.out
#SBATCH --error=/scratch/b/bengioy/breandan/slurm-%j.err
#SBATCH --mail-user=bre@ndan.co
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load CCEnv StdEnv/2020 java/17.0.2
commit_message=$(git log -1 --pretty=format:"%s" | sed 's/ /_/g')
java -Xmx150G -jar gym-fs-fat-1.0-SNAPSHOT.jar 2>&1 | tee /scratch/b/bengioy/breandan/log_${commit_message}.txt
