wrappedNode(label: 'docker') {
  deleteDir()
  stage "checkout"
  checkout scm

  tokens = "${env.JOB_NAME}".tokenize('/')
  org = tokens[0]
  repo = tokens[1]
  branch = tokens[2]
  pr = branch.substring(3) // remove the "PR-"
  echo "running ${pr}, job ${env.BUILD_ID}"
  sh "env"

  try {
    documentationChecker("docs")
  } catch (err) {
    slackSend channel: '#docs-automation', message: " ERROR: see pull request ${pr}"
    throw err
  }
}
