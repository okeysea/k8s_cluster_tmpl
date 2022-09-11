vultr_region = "nrt" # Tokyo
# k8s_master_plan = "vc2-1c-2gb" # memory 2gb required
# vultr_k8s_master_plan = "vc2-1c-1gb" # 構築用に一旦下げる
vultr_k8s_master_plan = "vhp-2c-2gb-intel"
vultr_k8s_worker_plan = "vc2-1c-1gb" # cheap instance
vultr_k8s_os_id       = 477          # debian 11 x64

k8s_masters_count = 1
k8s_workers_count = 0
