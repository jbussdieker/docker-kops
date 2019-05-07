#!groovy
node {
  kopsVersion = "1.11.1"

  stage('clone') {
    checkout scm
  }

  stage('build') {
    image = docker.build("jbussdieker/kops:${kopsVersion}", "--build-arg kops_version=${kopsVersion} .")
  }

  stage("test") {
    image.inside {
      sh "kops version | grep ${kopsVersion}"
    }
  }

  stage('publish') {
    image.push()
  }
}
