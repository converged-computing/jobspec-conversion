#!/bin/bash
#FLUX: --job-name=faux-lizard-5228
#FLUX: -t=169200
#FLUX: --priority=16

python get_attack.py --path_x_np '../data/lastfm/x_np.pkl' --path_edge_index '../data/lastfm/edge_index_np.pkl' --path_y '../data/lastfm/y_np.pkl' --save_edge_index '/home/users/yili/pycharm/GraphPrior/data/attack_data/lastfm/lastfm'
