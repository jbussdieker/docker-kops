#!groovy
properties([
  parameters([
    string(defaultValue: '1.11.1', description: 'Kops Version', name: 'KopsVersion')
  ])
])

node {
  kopsVersion = params.KopsVersion
  credentialsId = 'docker-hub-credentials'

  stage('clone') {
    checkout scm
  }

  stage('build') {
    image = docker.build("jbussdieker/kops:${kopsVersion}", "--build-arg kops_version=${kopsVersion} .")
  }

  stage('test') {
    image.inside {
      sh "kops version | grep ${kopsVersion}"
    }
  }

  stage('publish') {
    docker.withRegistry("", credentialsId) {
      image.push()
    }
  }
}
