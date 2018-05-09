node {
    ansiColor('xterm') {
        git branch: 'master', url: 'https://github.com/chongsk/mysqldb-app'
        def levant_docker = docker.image('jrasell/levant:0.0.4')
        levant_docker.pull()
 
        //def nomad_job = "${env.JOB_NAME}".tokenize( '_' )[3]
        //def nomad_env = "${env.JOB_NAME}".tokenize( '_' )[2]
        
        stage 'build image'
            sh """docker build -t mysql_php_consul ."""
            sh """docker tag mysql_php_consul:latest 127.0.0.1:5000/mysql_php_consul:latest"""
            sh """docker push 127.0.0.1:5000/mysql_php_consul:latest"""
        
        stage 'run job'
        
        levant_docker.inside {
              
              sh """
              levant deploy\
              -address=http://172.31.18.9:4646\
              -var-file=./demo.yaml\
              -log-level=debug\
              ./demo.nomad
              """
        }
    }
}