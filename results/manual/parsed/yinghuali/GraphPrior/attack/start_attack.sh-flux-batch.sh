#!/bin/bash
#FLUX: --job-name=expensive-noodle-0505
#FLUX: -n=2
#FLUX: --queue=gpu
#FLUX: -t=169200
#FLUX: --urgency=16

python get_attack.py --path_x_np '../data/lastfm/x_np.pkl' --path_edge_index '../data/lastfm/edge_index_np.pkl' --path_y '../data/lastfm/y_np.pkl' --save_edge_index '/home/users/yili/pycharm/GraphPrior/data/attack_data/lastfm/lastfm'
