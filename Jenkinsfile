pipeline {
    agent { label 'worker-node' }

    environment {
        ARTIFACT = 'angular-sample-small-project.zip'
        JFROG_REPO = 'angular_local'
        DEPLOY_DIR = '/var/www/angular-sample-small-project'
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/amitha-k/angular-sample-small-project.git'
            }
        }

        stage('Build') {
            steps {
                sh '''
                    npm install
                    npm run build
                '''
            }
        }

        stage('Create Artifact') {
            steps {
                sh '''
                    cd dist
                    zip -r ../${ARTIFACT} .
                    cd ..
                '''
            }
        }

        stage('Upload to JFrog') {
            steps {
                sh '''
                    jf rt upload \
                    ${ARTIFACT} \
                    ${JFROG_REPO}/angular-sample-small-project/${BUILD_NUMBER}/
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    sudo mkdir -p ${DEPLOY_DIR}
                    sudo rm -rf ${DEPLOY_DIR}/*
                    sudo unzip -o ${ARTIFACT} -d ${DEPLOY_DIR}
                '''
            }
        }
    }

    post {
        success {
            echo 'Angular application built, uploaded to JFrog, and deployed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}
