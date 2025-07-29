#!/bin/bash
#SBATCH --job-name=pmf_noGUI_try
#SBATCH --output=pmf_noGUI_try_%N_%j.out
#SBATCH --error=pmf_noGUI_try_%N_%j.err
#SBATCH --mail-user=tzhang23@gmu.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=3-00:00:00

module load singularity
DOS_COMMAND="ME-2 PMF_bs_6f8xx_sealed_GUI_MOD.ini"
cd "cd /projects/HAQ_LAB/tzhang/pmf_no_gui/file_try/PMF_no_GUI"
cp iniparams_base_1.txt iniparams.txt
singularity exec /projects/HAQ_LAB/tzhang/pmf_no_gui/file_try/dosbox_container.sif dosbox -c "mount c ." -c "c:" -c "$DOS_COMMAND" -c "exit"
rm iniparams.txt
