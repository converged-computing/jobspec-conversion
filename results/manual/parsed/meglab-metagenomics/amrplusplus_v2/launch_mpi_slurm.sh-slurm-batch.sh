#!/bin/bash
#SBATCH --job-name=AMRPlusPlus
#SBATCH --mail-user=enriquedoster@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=4-04:00:00
#SBATCH --qos=long

module purge
module load jdk/1.8.0
module load singularity/2.5.2
module spider openmpi/4.0.0
mpirun --pernode ./nextflow run main_AmrPlusPlus_v2.nf -resume -profile msi_pbs \
-w /work_dir --threads 15 \
--output output_results --host /PATH/TO/HOST/GENOME \
--reads "RAWREADS/*_R{1,2}.fastq.gz" -with-mpi
