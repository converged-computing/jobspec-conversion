#!/bin/bash
#SBATCH --job-name=run_OB1_simulations
#SBATCH --mail-user=a.t.lopesrego@vu.nl
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=A30:1
#SBATCH --time=20:00:00
#SBATCH --partition=defq

module load shared 2022
module load PyTorch/1.12.1-foss-2021a-CUDA-11.3.1
 cd $HOME/OB1-reader-model/src
python main.py "../data/processed/Provo_Corpus.csv" --number_of_simulations 100 --experiment_parameters_filepath "experiment_parameters_cloze.json" --analyze_results "True" --eye_tracking_filepath '../data/raw/Provo_Corpus-Eyetracking_Data.csv' --results_identifier 'prediction_flag' &
python main.py "../data/processed/Provo_Corpus.csv" --number_of_simulations 100 --experiment_parameters_filepath "experiment_parameters_gpt2.json" --analyze_results "True" --eye_tracking_filepath '../data/raw/Provo_Corpus-Eyetracking_Data.csv' --results_identifier 'prediction_flag' &
python main.py "../data/processed/Provo_Corpus.csv" --number_of_simulations 100 --experiment_parameters_filepath "experiment_parameters_llama.json" --analyze_results "True" --eye_tracking_filepath '../data/raw/Provo_Corpus-Eyetracking_Data.csv' --results_identifier 'prediction_flag' &
wait
