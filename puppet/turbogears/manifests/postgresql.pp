class turbogears::postgresql {
  package { 'postgresql':
    ensure => 'installed',
  }
  
  service { 'postgresql':
    ensure => 'running',
    enable => 'true',
    require => Package['postgresql'],
  }

  file { '/etc/postgresql/9.4/main/postgresql.conf':
    mode => 644,
    owner => 'postgres',
    group => 'postgres',
    require => Package['postgresql'],
    source => 'puppet:///modules/turbogears/etc/postgresql/9.3/main/postgresql.conf',
    notify => Service['postgresql'],
  }

  file { '/etc/postgresql/9.4/main/pg_hba.conf':
    mode => 640,
    owner => 'postgres',
    group => 'postgres',
    require => Package['postgresql'],
    source => 'puppet:///modules/turbogears/etc/postgresql/9.3/main/pg_hba.conf',
    notify => Service['postgresql'],
  }

  exec { 'createuser':
    require => [
                Service['postgresql'],
                File['/etc/postgresql/9.4/main/postgresql.conf'],
                File['/etc/postgresql/9.4/main/pg_hba.conf'],
                ],
    user => 'postgres',
    path => ['/usr/local/bin','/usr/bin','/bin'],
    unless => "psql -d template1 -c 'select rolname from pg_roles' | grep ${turbogears::dbuser}",
    command => "createuser -s -d -l -r ${turbogears::dbuser} && psql -d template1 -c \"alter user ${turbogears::dbuser} with password '${turbogears::dbpass}'\"",
  }

  exec { 'createdb':
    require => Exec['createuser'],
    user => 'postgres',
    path => ['/usr/local/bin','/usr/bin','/bin'],
    unless => "psql -d ${turbogears::dbname}",
    command => "createdb -O ${turbogears::dbuser} ${turbogears::dbname}",
  }


}
