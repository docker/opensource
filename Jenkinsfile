wrappedNode(label: 'docker') {
  deleteDir()
  stage "checkout"
  checkout scm

  pr = "${env.BUILD_ID}".substring(3) // remove the "PR-"

  try {
    documentationChecker("docs")
  } catch (err) {
    slackSend channel: '#docs-automation', message: " ERROR: see pull request ${pr}"
    throw err
  }
}
