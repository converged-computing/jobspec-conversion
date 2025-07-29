#!/bin/bash
#SBATCH --job-name=Tensor-Decomp
#SBATCH --account=kayvan1
#SBATCH --output=/nfs/turbo/med-kayvan-lab/Projects/DoD_Multimodal/Code/Joshua/datasets/EMG/epsilon_bounds/upper_bounds/1/logspaced/%x-%j.log
#SBATCH --mail-user=jpic@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=32
#SBATCH --array=2-10

matlab -nodisplay -r "driver_decomp(string('EMG'), string('epsilon_bounds/upper_bounds/1/logspaced'), $SLURM_ARRAY_TASK_ID); compile_feature_vectors(string('EMG'), string('epsilon_bounds/upper_bounds/1/logspaced')); exit"
