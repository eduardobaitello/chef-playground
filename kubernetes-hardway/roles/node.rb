name 'node'
description 'Node Role'
run_list 'recipe[common]', 'recipe[kubelet]'
