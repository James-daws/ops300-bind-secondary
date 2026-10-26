pipeline {
    agent { label 'build-agent' }

    environment {
        REGISTRY = 'registry.assign.jdawson10.300.ops:5000'
        IMAGE = 'bind-secondary'
    }

    triggers {
        pollSCM('H/5 * * * *')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'podman build -t ${REGISTRY}/${IMAGE}:${BUILD_NUMBER} .'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'registry-creds', usernameVariable: 'REG_USER', passwordVariable: 'REG_PASS')]) {
                    sh 'podman login -u $REG_USER -p $REG_PASS ${REGISTRY}'
                    sh 'podman push ${REGISTRY}/${IMAGE}:${BUILD_NUMBER}'
                    sh 'podman logout ${REGISTRY}'
                }
            }
        }
    }
}
