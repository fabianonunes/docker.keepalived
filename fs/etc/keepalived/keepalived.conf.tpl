{{ $priority := conv.ToInt64 (getenv "KEEPALIVED_PRIORITY" "100") -}}
{{ assert (and (ge $priority 1) (le $priority 255)) -}}

{{ $virtual_router_id := conv.ToInt64 .Env.KEEPALIVED_VIRTUAL_ROUTER_ID -}}
{{ assert (and (ge $virtual_router_id 1) (le $virtual_router_id 255)) -}}

global_defs {
  vrrp_version 2
  vrrp_garp_master_delay 1
  vrrp_mcast_group4 224.0.0.{{ $virtual_router_id }}
}

vrrp_script failover {
  script "/usr/local/bin/check-failover"
  timeout 1
  interval 1
  fall 1
  rise 1
}

vrrp_instance VI_1 {
  state BACKUP
  interface {{ .Env.KEEPALIVED_INTERFACE }}
  virtual_router_id {{ $virtual_router_id }}
  priority {{ $priority }}
  advert_int 1
  nopreempt

  track_script {
    failover
  }

  authentication {
    auth_type PASS
    auth_pass {{ getenv "KEEPALIVED_AUTH_PASS" "12345" }}
  }

  virtual_ipaddress {
    {{ net.ParseIPPrefix .Env.KEEPALIVED_VIRTUAL_ADDRESS }}
  }
}
