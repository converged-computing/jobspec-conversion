#!/bin/bash
#SBATCH --job-name=SEE-KOMATSUNA
#SBATCH --output=./KOMATSUNA_Benchmark_Output/slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=1-00:00:00
#SBATCH --array=1-300

cd see-segment; git log -n 1; cd ..
echo "Continuous Run Number $SLURM_ARRAY_TASK_ID"
timeout 85800s singularity exec -B /usr/bin/:/sysbin/ \
                 --env PATH=/miniconda3/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/sysbin/ \
                 --writable-tmpfs \
                 --env-file /opt/software/powertools/share/jupyter.env \
                 centos7.sif \
                 python KOMATSUNA_Batch.py --knum $SLURM_ARRAY_TASK_ID --num_iter 1000000 
echo "FINNISHED RUNNING JOB"
