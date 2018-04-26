job "mysqlapp" {
  datacenters = ["dc1"]
  region      = "global"
  type        = "batch"
  
  periodic{
    cron		= "*/2 * * * *"
    prohibit_overlap	= true
  }
  


  group "mysqlapp" {
    count = 1

    task "mysqlapp" {
	
      vault {
        policies = ["mysqldb"]

        change_mode   = "signal"
        change_signal = "SIGUSR1"
      }	

      driver = "exec"

	config {
		command = "cd repo; ./run.sh"
	}

	artifact {
		source      = "git::https://github.com/chongsk/mysqldb-app"
		destination = "local/repo"
			}
      
      service {
        name = "mysqlapp"
        tags = ["mysql", "app"]

        port = "http"
        address_mode = "host"

        check {
          type     = "http"
          address_mode = "host"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }

      resources {
        cpu    = 100
        memory = 200

        network {
          mbits = 1
          port  "http"{
			static = 5124		  
          }
        }
      }
    }
  }
}