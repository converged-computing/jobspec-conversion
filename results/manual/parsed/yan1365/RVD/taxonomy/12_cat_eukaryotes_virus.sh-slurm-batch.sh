#!/bin/bash
#SBATCH --job-name=cat_%j
#SBATCH --account=PAS0439
#SBATCH --output=cat_%j.out
#SBATCH --mail-user=yan1365,yan.1365@osu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

START=$SECONDS
part=${1}
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/cat 
cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/taxonomy/CAT
CAT contigs -c ../vOTU_10kb_vs2_vibrant_intersection/vOTU_10kb_vs2_vibrant_intersection.part_${part}.fa -d /fs/scratch/PAS0439/Ming/databases/CAT/CAT_prepare_20210107/2021-01-07_CAT_database -t /fs/scratch/PAS0439/Ming/databases/CAT/CAT_prepare_20210107/2021-01-07_taxonomy/ -p ../diamond/vOTU_10kb_vs2_vibrant_intersection.part_${part}.faa   -n 40 --out_prefix vOTU_above10kb.part_${part}  --tmpdir ../tmp
CAT add_names -i vOTU_above10kb.part_${part}.contig2classification.txt -o vOTU_above10kb.part_${part}.contig2classification.official_names.txt -t /fs/scratch/PAS0439/Ming/databases/CAT/CAT_prepare_20210107/2021-01-07_taxonomy/ --only_official
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
