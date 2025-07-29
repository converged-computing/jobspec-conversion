#!/bin/bash
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --gres=a100:4
#SBATCH --mem=512G
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

date;hostname;pwd
module load singularity
SINGULARITY_IMAGE="/blue/vendor-nvidia/hju/clara-parabricks-4.0.1-1"
DATA_DIR="/blue/vendor-nvidia/hju/data_parabricks/parabricks_sample"
SAMPLE_1="${DATA_DIR}/Data/sample_1.fq.gz"
SAMPLE_2="${DATA_DIR}/Data/sample_2.fq.gz"
REFERENCE="${DATA_DIR}/Ref/Homo_sapiens_assembly38.fasta"
IN_BAM="${DATA_DIR}/output.bam"
OUT_VARIANTS="${DATA_DIR}/deepvariant.vcf"
singularity exec \
    --nv \
    --bind ${DATA_DIR}:${DATA_DIR} \
    ${SINGULARITY_IMAGE} \
    pbrun deepvariant \
        --ref ${REFERENCE} \
        --in-bam ${IN_BAM} \
        --out-variants ${OUT_VARIANTS} \
        --num-gpus 4
