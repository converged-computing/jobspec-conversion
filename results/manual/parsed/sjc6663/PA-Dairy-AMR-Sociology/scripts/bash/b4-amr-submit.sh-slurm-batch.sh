#!/bin/bash
#SBATCH --job-name=Rans4-AMR
#SBATCH --account=open
#SBATCH --output=Rans4-AMR.out
#SBATCH --error=Rans4-AMR.err
#SBATCH --mail-user=sjc6663@psu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=2-00:00:00

export NXF_WORK='/storage/home/sjc6663/scratch/nf-work-rans/b4'

echo "Job started at $(date)"
READS=/storage/group/evk5387/default/stephanie/ransom-amr++/bovine-host/b4
OUT=/storage/home/sjc6663/scratch/ransom-out/b4
cd /storage/home/sjc6663/work/amr++/setup/amrplusplus_v2
module load anaconda3
source activate base
conda activate bioinfo
export NXF_WORK=/storage/home/sjc6663/scratch/nf-work-rans/b4
NXF_VER=22.10.5 ../nextflow run main_AmrPlusPlus_v2.nf -profile local --reads "${READS}/R*_merged_R{1,2}.fastq.gz" --output "${OUT}" --threshold 0 --max-threads 20
echo "Job ended at $(date)"
