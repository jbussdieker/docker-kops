#!groovy
latest = "1.14.0-alpha.1"
stable = "1.11.1"

properties([
  parameters([
    string(defaultValue: '1.11.1', description: 'Version', name: 'Version')
  ])
])

node {
  kopsVersion = params.Version
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
      if (kopsVersion == latest)
        image.push('latest')
      if (kopsVersion == stable)
        image.push('stable')
    }
  }
}
