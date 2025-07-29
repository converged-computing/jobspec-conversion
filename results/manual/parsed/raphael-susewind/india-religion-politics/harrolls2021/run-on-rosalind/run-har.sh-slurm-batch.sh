#!/bin/bash
#SBATCH --job-name=har
#SBATCH --output=har.array.%A.%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --array=1-90

mkdir /scratch/users/k1639346/ceoharyana.nic.in/Voter-List-2021/$SLURM_ARRAY_TASK_ID
cd /scratch/users/k1639346/ceoharyana.nic.in/Voter-List-2021/$SLURM_ARRAY_TASK_ID
module load apps/singularity
module load devtools/python
cp /scratch/users/k1639346/ceoharyana.nic.in/Voter-List-2021/run-on-rosalind/* .
perl -CSDA downloadpdf.pl $SLURM_ARRAY_TASK_ID
perl -CSDA transform-to-ocr-pdfs.pl
mkfifo fifo
perl -CSDA subcontrol.pl $SLURM_ARRAY_TASK_ID
