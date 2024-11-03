pipeline {
    agent {
    node {
        label 'AGENT-1'
        
    }
}

// environment { 
//     packageVersion = ''
//     nexusURL = '172.31.39.211:8081'
//     }

    options {
                timeout(time: 1, unit: 'HOURS') 
                disableConcurrentBuilds() 
                ansiColor('xterm')
    }


    stages {
        stage('VPC') {
            steps {
                sh """
                cd 01-vpc
                terraform init -reconfigure
                terraform apply -auto-approve
                """
            }
        }


        stage('Security_Groups') {
            steps {
                sh """
                cd 02-security_groups
                terraform init -reconfigure
                terraform apply -auto-approve
                """
            }
        }

        stage('vpn') {
            steps {
                sh """
                cd 03-vpn
                terraform init -reconfigure
                terraform apply -auto-approve
                """
            }
        }

        stage('DB and ALB') {
            parallel {
                stage('DB') {
                    steps {
                        sh """
                            cd 04-databases
                            terraform init -reconfigure
                            terraform apply -auto-approve
                            """
                    }
                }
                stage('ALB') {
                    steps {
                        sh """
                            cd 05-app-alb
                            terraform init -reconfigure
                            terraform apply -auto-approve
                            """
                    }
                }
            }
        }




    post { 
        always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }

        success { 
            echo 'The Job has ran  successfully!'
        }

        failure { 
            echo 'Useful when alerts has to send upon failure'
        }
    }
}
