#!/bin/bash
#SBATCH --job-name=wang_atlas_mapping
#SBATCH --output=/mnt/beegfs/XNAT/COGITATE/ECoG/phase_2/processed/bids/derivatives/fs/wang_atlas_mapping-%A_%a.out
#SBATCH --mail-user=alex.lepauvre@ae.mpg.de
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=1-00:00:00

export SUBJECTS_DIR='$FREESURFER_PATH'

subject=""
FREESURFER_PATH=""
singularity_path=""
while [ $# -gt 0 ]; do
  case "$1" in
    --FREESURFER_PATH=*)
      FREESURFER_PATH="${1#*=}"
      ;;
    --singularity_path=*)
      singularity_path="${1#*=}"
      ;;
    --subject=*)
      subject="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument: ${1}*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
done
echo $subject
echo $FREESURFER_PATH
SCRIPTS_DIR=$(pwd)
echo "Setting environment"
module purge; module load Anaconda3/2020.11;
source /hpc/shared/EasyBuild/apps/Anaconda3/2020.11/bin/activate;
conda activate /hpc/users/$USER/.conda/envs/mne_ecog02
module load FreeSurfer/6.0.1-centos6_x86_64; source ${FREESURFER_HOME}/SetUpFreeSurfer.sh
export SUBJECTS_DIR=$FREESURFER_PATH
python -m neuropythy atlas --verbose --atlases='wang15' --volume-export $subject
