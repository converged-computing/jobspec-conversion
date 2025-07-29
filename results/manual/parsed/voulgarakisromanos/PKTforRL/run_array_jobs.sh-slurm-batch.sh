#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --output=job_%A_%a.out
#SBATCH --error=job_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-8

commands=(
    "julia --project=. src/scripts/train_student.jl --env Lift --run_name Lift_linear_mse_rep_001_no_1 --similarity_function linear --pre_steps 0 --repr_weight 0.01 --total_steps 30000"
    "julia --project=. src/scripts/train_student.jl --env Lift --run_name Lift_linear_mse_rep_001_no_2 --similarity_function linear --pre_steps 0 --repr_weight 0.01 --total_steps 30000"
    "julia --project=. src/scripts/train_student.jl --env Lift --run_name Lift_linear_mse_rep_001_no_3 --similarity_function linear --pre_steps 0 --repr_weight 0.01 --total_steps 30000"
    "julia --project=. src/scripts/train_student.jl --env Lift --run_name Lift_linear_mse_rep_001_no_4 --similarity_function linear --pre_steps 0 --repr_weight 0.01 --total_steps 30000"
    "julia --project=. src/scripts/train_student.jl --env Lift --run_name Lift_linear_mse_rep_10_no_1 --similarity_function linear --pre_steps 0 --repr_weight 10.0 --total_steps 30000"
    "julia --project=. src/scripts/train_student.jl --env Lift --run_name Lift_linear_mse_rep_10_no_2 --similarity_function linear --pre_steps 0 --repr_weight 10.0 --total_steps 30000"
    "julia --project=. src/scripts/train_student.jl --env Lift --run_name Lift_linear_mse_rep_10_no_3 --similarity_function linear --pre_steps 0 --repr_weight 10.0 --total_steps 30000"
    "julia --project=. src/scripts/train_student.jl --env Lift --run_name Lift_linear_mse_rep_10_no_4 --similarity_function linear --pre_steps 0 --repr_weight 10.0 --total_steps 30000"
   )
command=${commands[$SLURM_ARRAY_TASK_ID-1]}
$command
