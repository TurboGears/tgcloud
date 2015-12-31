class turbogears {
  $dbuser = "vagrant"
  $dbpass = "vagrant"
  $dbhost = "localhost"
  $dbname = "appdb"
  $dbport = "5432"

  $web_error_from_email = "turbogears@localhost"
  $web_error_smtp_server = "localhost"
  $web_session_secret = "772d3160-75ef-4eb6-8f3a-3945b54def68"
  
  $pythonver = "3.4" # valid values are "2.7" "3.4" - this is used in the path for the virtualenv that gets made
  $dbtype = "postgres" # valid values are "postgres" "mysql" "mongodb"
  $webserver = "apache" # valid values are "apache", but others can be added

  include turbogears::tgapp
  
  case $dbtype {
    "postgres" : { include turbogears::postgresql }
    "mysql":     { include turbogears::mysql      }
    "mongodb":   { include turbogears::mongodb    }
  }

  case $webserver {
    "apache":  { include turbogears::apache }
  }

  case $pythonver {
    "2.7" : { include turbogears::python2 }
    "3.4" : { include turbogears::python3 }
  }
}
