def remote = [: ]
remote.name = "ubuntu"
remote.host = "172.31.30.51"
remote.allowAnyHosts = true
node {
  checkout scm
  withCredentials([string(credentialsId: 'docker_hub', variable: 'DOCKER_HUB')]) {
    sh '''
    sudo docker build -t akashp/flask_test_ap .
    sudo docker tag akashp/flask_test_ap akashp/flask_test_ap:1.0.${BUILD_ID}
    sudo docker login --username akashp --password ${DOCKER_HUB}
    sudo docker push akashp/flask_test_ap:1.0.${BUILD_ID}
    '''
  }

  withCredentials([sshUserPrivateKey(credentialsId: 'd0725c75-6973-40ee-bbd9-afb1f3695ca9', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'ubuntu')]) {
    remote.user = ubuntu
    remote.identityFile = identity
    stage("Deploy on flash-server") {
      sshCommand remote: remote, command: "sudo docker stop \$(sudo docker ps -a -q)"
	  sshCommand remote: remote, command: "sudo docker run -dit -p 5050:5050 akashp/flask_test_ap:1.0.${BUILD_ID}"
    }
  }
}