# https://collectd.org/wiki/index.php/Plugin:Routeros
class collectd::plugin::routeros (
  $ensure           = present,
  $host             = "127.0.0.1",
  $user             = "admin",
  $password         = "admin",
  $collectinterface = false,
  $collectcpuload   = false,
  $collectmemory    = false,
  $collectregistrationtable = false,
  $collectdf        = false,
  $collectdisk      = false
) {
  include collectd::params

  $conf_dir = $collectd::params::plugin_conf_dir
  validate_bool(
    $collectinterface,
    $collectcpuload,
    $collectmemory,
    $collectregistrationtable,
    $collectdf,
    $collectdisk
  )

  file { 'routeros.conf':
    ensure    => $collectd::plugin::routeros::ensure,
    path      => "${conf_dir}/routeros.conf",
    mode      => '0644',
    owner     => 'root',
    group     => $collectd::params::root_group,
    content   => template('collectd/routeros.conf.erb'),
    notify    => Service['collectd'],
  }
}

