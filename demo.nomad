job "mysqlapp2" {
  datacenters = ["[[.datacenter]]"]
  region      = "[[.region]]"
  type        = "batch"
  
  periodic{
    cron		= "*/1 * * * *"
    prohibit_overlap	= true
  }
  


  group "mysqlapp2" {
    count = 1

    task "mysqlapp2" {
	
      vault {
        policies = ["mysqldb"]
      }	

	artifact {
		source      = "git::https://github.com/chongsk/mysqldb-app"
		destination = "local/repo2"		
			}
			
  driver = "docker"
  
  config {
    image = "127.0.0.1:5000/cits/mysql_php_consul:[[.version]]"
    volumes = ["local/repo2:/usr/src/myapp"]
  }

  env {  
  	"PHP_SCRIPTNAME"="/usr/src/myapp/test/mysql.php"
	"CONSUL_TEMPLATE_URL"="/usr/src/myapp/test/conn.inc.ctmpl"
	"CONSUL_HTTP_ADDR"="172.31.18.9:8500"
	"VAULT_ADDR"="https://172.31.18.9:8200"
  }	  

      
      service {
        name = "mysqlapp"
        tags = ["mysql", "app"]

        port = "http"

        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }

      resources {
        cpu    = [[.cpu]]
        memory = [[.memory]]

        network {
          mbits = [[.mbits]]
          port  "http"{}
        }
      }
    }
  }
}


