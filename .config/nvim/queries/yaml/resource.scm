(stream(
        (document
          (block_node
            (block_mapping
              (block_mapping_pair
                key: (flow_node (plain_scalar (string_scalar) @apiVersion_key))
                value: (flow_node (plain_scalar (string_scalar) @apiVersion))
                (#eq? @apiVersion_key "apiVersion"))
              (block_mapping_pair
                key: (flow_node (plain_scalar (string_scalar) @kind_key))
                value: (flow_node (plain_scalar (string_scalar) @kind))
                (#eq? @kind_key "kind"))
              (block_mapping_pair
                key: (flow_node (plain_scalar (string_scalar) @metadata_key))
                value: (block_node
                         (block_mapping
                           (block_mapping_pair
                             key: (flow_node (plain_scalar (string_scalar) @name_key))
                             value: (flow_node (plain_scalar (string_scalar) @name))
                             (#eq? @name_key "name"))
                           (block_mapping_pair
                             key: (flow_node (plain_scalar (string_scalar) @namespace_key))
                             value: (flow_node (plain_scalar (string_scalar) @namespace))
                             (#eq? @namespace_key "namespace"))))
                (#eq? @metadata_key "metadata"))
              ) @root
            )
          )
        )
  )
