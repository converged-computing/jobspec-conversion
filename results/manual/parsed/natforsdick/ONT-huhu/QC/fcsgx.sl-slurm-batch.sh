#!/bin/bash
#SBATCH --job-name=fcsgx
#SBATCH --account=ga03048
#SBATCH --output=%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=ssd
#SBATCH --mem=3G
#SBATCH --time=7-00:00:00
#SBATCH --partition=milan
#SBATCH --array=0

export PATH='/nesi/project/landcare03691/fcs-gx/scripts:$PATH'
export TMPDIR='/nesi/nobackup/ga03048/fcsgx'
export GX_NUM_CORES='16'
export LOCAL_DB='/nesi/nobackup/nesi02659/LRA/resources/fcs/gxdb'
export GXDB_LOC='$TMPDIR'

REFDIR=/nesi/nobackup/ga03186/Huhu_MinION/combined-trimmed-data/omnic-scaffolding/shasta-purged-polished-omnic/yahs/
TAXID=508667
OUTDIR=/nesi/nobackup/ga03186/Huhu_MinION/combined-trimmed-data/omnic-scaffolding/shasta-purged-polished-omnic/yahs/fcs-gx/
FCS=/nesi/project/landcare03691/fcs-gx/
FILES=($(<${REFDIR}filelist.txt))
FILENAME=${FILES[${SLURM_ARRAY_TASK_ID}]}
echo $FILENAME
module purge
module load Python/3.8.2-gimkl-2020a
export PATH=/nesi/project/landcare03691/fcs-gx/dist:$PATH
export PATH=/nesi/project/landcare03691/fcs-gx/scripts:$PATH
export TMPDIR=/nesi/nobackup/ga03048/fcsgx
export GX_NUM_CORES=16
export LOCAL_DB=/nesi/nobackup/nesi02659/LRA/resources/fcs/gxdb
export GXDB_LOC=$TMPDIR
mkdir -p ${OUTDIR}${FILENAME}
cd ${OUTDIR}${FILENAME}
echo running GX module for $FILENAME
run_gx --fasta ${REFDIR}${FILENAME} --tax-id $TAXID --gx-db "$GXDB_LOC/gxdb" --out-dir ${OUTDIR}${FILENAME}
