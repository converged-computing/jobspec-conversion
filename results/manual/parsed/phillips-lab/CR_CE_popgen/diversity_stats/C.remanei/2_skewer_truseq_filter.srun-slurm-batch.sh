#!/bin/bash
#SBATCH --job-name=filt1
#SBATCH --account=phillipslab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=04:00:00
#SBATCH --partition=phillips
#SBATCH --array=0-39

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load easybuild  icc/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132 skewer
cd /projects/phillipslab/ateterina/CR_popgen/data/reads/
LISTFILES=(*.fastq)
file=${LISTFILES[$SLURM_ARRAY_TASK_ID]}
skewer -x AGATCGGAAGAG -t 4 -q 20 -l 36 -d 0.1 -r 0.1 -o ${file/_1.fastq/.tr1} $file ${file/_1.fastq/_2.fastq};
mv ${file/_1.fastq/.tr1-trimmed-pair1.fastq} ${file/_1.fastq/_fp1.ok.fastq}
mv ${file/_1.fastq/.tr1-trimmed-pair2.fastq} ${file/_1.fastq/_fp2.ok.fastq}
