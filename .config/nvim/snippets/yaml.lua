local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local kubernetes = require "utils.kubernetes"
local kubernetes_namespaces = kubernetes.get_namespaces()

local namespaces = {}
for idx, namespace in ipairs(kubernetes_namespaces) do
  table.insert(namespaces, i(idx, namespace))
end

return {
  -- ServiceAccount snippet
  s(
    "k-serviceaccount",
    fmt(
      [[
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {}
  namespace: {}
{}
    ]],
      {
        i(1, "app-serviceaccount"),
        i(2, "default"),
        c(3, {
          t "",
          t "automountServiceAccountToken: false",
        }),
      }
    )
  ),

  -- Role snippet
  s(
    "k-role",
    fmt(
      [[
apiVersion: rbac.authorization.k8s.io/v1
kind: {}
metadata:
  name: {}
  {}
rules:
  - apiGroups: {}
    resources: {}
    verbs: {}
    ]],
      {
        c(1, {
          t "Role",
          t "ClusterRole",
        }),
        i(2, "app-role"),
        c(3, {
          fmt("namespace: {}", { i(1, "default") }),
          t "",
        }),
        i(4, '[""]'),
        i(5, '["pods", "services"]'),
        i(6, '["get", "list", "watch"]'),
      }
    )
  ),

  -- RoleBinding snippet
  s(
    "k-rolebind",
    fmt(
      [[
apiVersion: rbac.authorization.k8s.io/v1
kind: {}
metadata:
  name: {}
  {}
subjects:
  - kind: ServiceAccount
    name: {}
    namespace: {}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: {}
  name: {}
    ]],
      {
        c(1, {
          t "RoleBinding",
          t "ClusterRoleBinding",
        }),
        i(2, "app-rolebinding"),
        c(3, {
          fmt("namespace: {}", { i(1, "default") }),
          t "",
        }),
        i(4, "app-serviceaccount"),
        i(5, "default"),
        c(6, {
          t "Role",
          t "ClusterRole",
        }),
        i(7, "app-role"),
      }
    )
  ),
  s(
    "k-kust",
    fmt(
      [[
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - {}
    ]],
      {
        i(1, "./namespace.yaml"),
      }
    )
  ),
  -- Kustomization snippet
  s(
    "fluxk",
    fmt(
      [[
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: &app {}
  namespace: {}
spec:
  targetNamespace: {}
  commonMetadata:
    labels:
      app.kubernetes.io/name: *app
  path: ./kubernetes/apps/{}/{}/app
  prune: true
  sourceRef:
    kind: GitRepository
    name: {}
  wait: {}
  interval: {}
  retryInterval: {}
  timeout: {}
    ]],
      {
        i(1, "app-name"),
        i(2, "flux-system"),
        i(3, "default"),
        rep(3), -- repeats the targetNamespace value
        rep(1), -- repeats the app name
        i(4, "home-kubernetes"),
        i(5, "true"),
        i(6, "30m"),
        i(7, "1m"),
        i(8, "5m"),
      }
    )
  ),

  -- HelmRelease snippet
  s(
    "fluxc",
    fmt(
      [[
apiVersion: helm.toolkit.fluxcd.io/v2beta2
kind: HelmRelease
metadata:
  name: &app {}
  namespace: {}
spec:
  interval: {}
  chart:
    spec:
      chart: {}
      version: {}
      sourceRef:
        kind: HelmRepository
        name: {}
        namespace: {}
  maxHistory: {}
  install:
    createNamespace: true
    remediation:
      retries: {}
  upgrade:
    remediation:
      retries: {}
  values:
    {}
    ]],
      {
        i(1, "app-name"),
        i(2, "default"),
        i(3, "30m"),
        i(4, "app"),
        i(5, "1.2.3"),
        i(6, "repo-name"),
        i(7, "flux-system"),
        i(8, "3"),
        i(9, "3"),
        i(10, "3"),
        i(11, ""),
      }
    )
  ),

  s(
    "k-namespace",
    fmt(
      [[
apiVersion: v1
kind: Namespace
metadata:
 name: {}
]],
      {
        i(1, "default"),
      }
    )
  ),
  s(
    "k-virtualservice",
    fmt(
      [[
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: {}
  namespace: {}
spec:
  hosts:
    - {}.${{SECRET_DOMAIN}}
  gateways:
    - istio-ingress/external-gateway 
  http:
    - match:
        - uri:
            prefix: /
      route:
        - destination:
            host: {}.{}.svc.cluster.local
            port:
              number: {}
    ]],
      {
        i(1, "app-name"),
        -- i(2, "app-namespace"),
        c(2, namespaces),
        i(3, "app-subdomain"),
        i(4, "servce-name"),
        rep(2), -- repeats the namespace value
        i(5, "80"),
      }
    )
  ),
}
