class turbogears::mysql {
  package { 'mysql-server':
    ensure => installed,
  }

  service { 'mysql':
    ensure => 'running',
    enable => 'true',
    require => Package['mysql-server'],    
  }

  file { '/etc/mysql/my.cnf':
    mode => 644,
    owner => 'root',
    group => 'root',
    require => Package['mysql-server'],
    source => 'puppet:///modules/turbogears/etc/mysql/my.cnf',
    notify => Service['mysql'],
  }

  exec { 'createuser':
    require => [
                Service['mysql'],
                File['/etc/mysql/my.cnf'],
                ],
    user => 'root',
    path => ['/usr/local/bin','/usr/bin','/bin'],
    unless => "mysql -u root mysql -e 'select user from user' | grep ${turbogears::dbuser}",
    command => "mysql -u root mysql -e 'grant all on *.* to \"${turbogears::dbuser}\"@\"localhost\" identified by \"${turbogears::dbpass}\"; flush privileges'"
  }

  #TODO: add createdb section
}
