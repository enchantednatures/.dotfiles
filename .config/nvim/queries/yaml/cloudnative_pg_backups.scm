; Get current cluster name
(block_mapping_pair
  key: (flow_node) @key (#eq? @key "serverName")
  value: (flow_node (plain_scalar) @current_cluster_name))

; Get backup/recovery source cluster name
(block_mapping_pair
  key: (flow_node) @key (#eq? @key "source")
  value: (flow_node (plain_scalar) @recovery_cluster_name))

; Get cluster metadata name
(block_mapping_pair
  key: (flow_node) @key (#eq? @key "name")
  value: (flow_node (plain_scalar) @cluster_name)
  (#has-ancestor? @key "metadata"))
