#!/bin/bash
#SBATCH --mail-user=yinghua.li@uni.lu
#SBATCH --mail-type=end,fail
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --mem-per-cpu=700G
#SBATCH --time=1-23:00:00
#SBATCH --constraint=skylake

python get_attack.py --path_x_np '../data/lastfm/x_np.pkl' --path_edge_index '../data/lastfm/edge_index_np.pkl' --path_y '../data/lastfm/y_np.pkl' --save_edge_index '/home/users/yili/pycharm/GraphPrior/data/attack_data/lastfm/lastfm'
