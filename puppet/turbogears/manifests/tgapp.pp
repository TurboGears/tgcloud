class turbogears::tgapp {
  $app = "testapp"
  $tgbase = "/opt/turbogears"
  $tgappdir = "${tgbase}/app"
  $venv = "${tgappdir}/venv"

  file { [$tgbase, $tgappdir, $venv]:
    ensure => 'directory',
    mode => 0755,
    group => root,
    owner => root,
  }
  
  case $turbogears::pythonver {
    "2.7" : {
      exec { 'virtualenv2':
        command => "/usr/bin/virtualenv --no-site-packages ${venv}",
        creates => "${venv}/bin/activate",
        require => File["${venv}"],
        before => Exec['installtgdevtools'],
      }      
    }
    "3.4" : {
      exec { 'virtualenv3':
        command => "/usr/bin/pyvenv ${venv}",
        creates => "${venv}/bin/activate",
        require => File["${venv}"],
        before => Exec['installtgdevtools'],
      }
    }
  }

  exec { 'installtgdevtools':
    command => "${venv}/bin/pip install tg.devtools",
    unless => "${venv}/bin/python -c 'import tg.devtools'",
  }
  
  exec { 'installapp':
    command => "${venv}/bin/gearbox quickstart -a -j -s ${app}",
    require => Exec['installtgdevtools'],
    cwd => $tgappdir,
    unless => "${venv}/bin/python -c 'import tg.devtools'",
  }

  exec { 'installpip':
    command => "${venv}/bin/pip install psycopg2",
    require => Exec['installapp'],
    cwd => $tgappdir,
  }

  exec { 'setuppy':
    command => "${venv}/bin/python ${tgappdir}/${app}/setup.py develop",
    require => Exec['installpip'],
    cwd => "$tgappdir/$app",
    #unless => "${venv}/bin/python -c 'import ${app}'",
  }

  exec { 'setupapp':
    command => "${venv}/bin/gearbox setup-app -c ${tgappdir}/production.ini",
    cwd     => "$tgappdir/$app",
    require => Exec['setuppy']
  }

  file { 'production.ini':
    path    => "${tgappdir}/production.ini",
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0644',
    require => Exec[setuppy],
    content => template('turbogears/production.ini.erb'),
  }

  file { 'app.wsgi':
    path    => "${tgappdir}/app.wsgi",
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0744',
    require => File['production.ini'],
    content => template('turbogears/app.wsgi.erb'),
  }

  file { 'apache-default':
    path    => "/etc/apache2/sites-available/000-default.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('turbogears/000-default.conf.erb'),
  }

  exec { 'reloadapache':
    command => '/usr/sbin/service apache2 reload',
    user => 'root',
    require => [ File['apache-default'], File['app.wsgi'], File['production.ini'], Exec['setupapp']]
  }

  # TODO: support ming/mongo in production.ini
}
