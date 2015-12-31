class turbogears::apache {
  package { 'apache2':
    ensure => installed,
  }

  case $turbogears::pythonver {
    "2.7" : {
      package { 'libapache2-mod-wsgi':
        ensure => installed,
        require => Package['apache2'],
      }

      exec { 'wsgi2enable':
        user => 'root',
        command => '/usr/sbin/a2enmod wsgi'
      }

      exec { 'apachereload2':
        user => 'root',
        command => '/usr/sbin/service apache2 reload',
        require => Exec['wsgi2enable'],
      }
    }

    "3.4" : {
      package { 'libapache2-mod-wsgi-py3':
        ensure => installed,
        require => Package['apache2'],
      }

      exec { 'wsgi3enable':
        user => 'root',
        command => '/usr/sbin/a2enmod wsgi'
      }

      exec { 'apachereload3':
        user => 'root',
        command => '/usr/sbin/service apache2 reload',
      require => Exec['wsgi3enable'],
      }
    }
  }
}
