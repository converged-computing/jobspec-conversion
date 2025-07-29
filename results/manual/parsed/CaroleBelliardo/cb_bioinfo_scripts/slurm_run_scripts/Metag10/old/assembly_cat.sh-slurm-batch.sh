#!/bin/bash
#SBATCH --job-name=mg
#SBATCH --output=slurm-mg-%j.out
#SBATCH --error=slurm-mg-%j.err
#SBATCH --mail-user=carole.belliardo@inrae.fr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=70
#SBATCH --mem=670G
#SBATCH --partition=infinity

module load singularity/3.5.3
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/MetagAssembler.sif'
SING2='singularity exec --bind /bighub/hub:/bighub/hub:rw --bind /lerins/hub:/lerins/hub'
cd '/lerins/hub/projects/25_IPN_Metag/10Metag/0-cat/'
FILENAME='cat_10metag.fasta'
hismR='hifiasm3'
SING_IMG='/lerins/hub/projects/25_Metag_PublicData/tools_metagData/Singularity/pb-metagToolkit2.sif'
SING2='singularity exec  --bind /work/cbelliardo:/work/cbelliardo  --bind /lerins/hub:/lerins/hub'
FILENAME=hifiasm3.p_ctg.gfa
cd /lerins/hub/projects/25_IPN_Metag/HiFi-MAG-Pipeline_pacbio/HiFi-MAG-Pipeline_cat
$SING2 $SING_IMG /home/tools/conda/bin/snakemake --snakefile Snakefile-hifimags --configfile configs/Sample-Config.yaml -j 70 --use-conda #--conda-frontend conda
