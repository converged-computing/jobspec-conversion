#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8048M
#SBATCH --time=1-00:00:00

export PBS_NODEFILE='`/fslapps/fslutils/generate_pbs_nodefile`'
export PBS_JOBID='$SLURM_JOB_ID'
export PBS_O_WORKDIR='$SLURM_SUBMIT_DIR'
export PBS_QUEUE='batch'
export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export PBS_NODEFILE=`/fslapps/fslutils/generate_pbs_nodefile`
export PBS_JOBID=$SLURM_JOB_ID
export PBS_O_WORKDIR="$SLURM_SUBMIT_DIR"
export PBS_QUEUE=batch
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
valgrind  --track-origins=yes --tool=memcheck --leak-check=yes --show-reachable=yes --num-callers=20 --track-fds=yes bin/gnumap-plain -g /fslhome/masaki/compute/human_genome/GCA_000001405.18_GRCh38.p3_genomic.fna --print_all_sam -o y.sim_reads.filtered examples/1.fq
