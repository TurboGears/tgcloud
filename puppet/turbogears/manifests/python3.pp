class turbogears::python3 {
  package { 'python3':
    ensure => installed,
  }
  
  package { 'python3-dev':
    ensure => installed,
  }
  
  package { 'python3-pip':
    ensure => installed,
  }
  
  package { 'python3-venv':
    ensure => installed,
    before => File[$turbogears::tgapp::venv],
  }
}
