

normal.elasticsearch['version'] = '1.1.0'
normal.elasticsearch['cluster']['name'] = 'elasticsearch'
normal.elasticsearch['node']['master'] = true
normal.elasticsearch['node']['data'] = true
normal.elasticsearch['logging']['action.discovery.ec2'] = 'WARN'
normal.elasticsearch['plugins']['elasticsearch/elasticsearch-cloud-aws']['version'] = '2.1.0'
normal.elasticsearch['cloud']['aws']['region'] = 'eu-west-1'
normal.elasticsearch['index']['number_of_shards'] = 3
normal.elasticsearch['index']['number_of_replicas'] = 2
normal.elasticsearch['discovery']['type'] = 'ec2'
normal.elasticsearch['discovery']['zen']['minimum_master_nodes'] = 1
normal.elasticsearch['discovery']['ping']['multicast']['enabled'] = false
normal.elasticsearch['discovery']['ec2']['tag']['opsworks:stack'] = "elasticsearch"
normal.elasticsearch['limits']['nofile'] = 655350
normal.elasticsearch['custom_config']['cluster.routing.allocation.awareness.attributes'] = 'aws_availability_zone'
normal.elasticsearch['custom_config']['index.refresh_interval'] = '3s'
normal.elasticsearch['custom_config']['indices.fielddata.cache.size'] = '15%'
normal.elasticsearch['custom_config']['indices.fielddata.cache.expire'] = '1h'
normal.elasticsearch['custom_config']['indices.cache.filter.size'] = '15%'


if node[:opsworks][:instance][:layers].include? 'elasticsearch-frontend'

    # httpnode
    normal.elasticsearch['node']['master'] = true
    normal.elasticsearch['node']['data'] = false
    normal.elasticsearch['nginx']['allow_cluster_api'] = true
    normal.elasticsearch['nginx']['port'] = 80
    normal.elasticsearch['plugins']['karmi/elasticsearch-paramedic'] = {}
    normal.elasticsearch['plugins']['lmenezes/elasticsearch-kopf']['version'] = '0.5.5'
    normal.elasticsearch['plugins']['royrusso/elasticsearch-HQ'] = {}
    normal.elasticsearch['plugins']['karmi/elasticsearch-paramedic'] = {}

end

if node[:opsworks][:instance][:layers].include? 'elasticsearch-data'

    # datanode
    normal.elasticsearch['node']['master'] = false
    normal.elasticsearch['node']['data'] = true
    normal.elasticsearch['custom_config']['indices.memory.index_buffer_size'] = '60%'

end
