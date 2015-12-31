class turbogears::python2 {
  package { 'python-dev':
    ensure => installed,
  }
  
  package { 'python-pip':
    ensure => installed,
  }
  
  package { 'python-virtualenv':
    ensure => installed,
    before => File[$turbogears::tgapp::venv],
  }
}
