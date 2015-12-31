class turbogears::mongodb {
  package { 'mongodb':
    ensure => installed,
  }

  service { 'mongodb':
    ensure => 'running',
    enable => 'true',
    require => Package['mongodb'],    
  }

  file { '/etc/mongodb.conf':
    mode => 644,
    owner => 'root',
    group => 'root',
    require => Package['mongodb'],
    source => 'puppet:///modules/turbogears/etc/mongodb.conf',
    notify => Service['mongodb'],
  }
}
