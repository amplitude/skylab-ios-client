module.exports = {
  "branches": ["main"],
  "plugins": [
    ["@semantic-release/commit-analyzer", {
      "preset": "angular",
      "parserOpts": {
        "noteKeywords": ["BREAKING CHANGE", "BREAKING CHANGES", "BREAKING"]
      }
    }],
    ["@semantic-release/release-notes-generator", {
      "preset": "angular",
    }],
    ["@semantic-release/changelog", {
      "changelogFile": "CHANGELOG.md"
    }],
    "@semantic-release/github",
    [
      "@google/semantic-release-replace-plugin",
      {
        "replacements": [
          {
            "files": ["AmplitudeSkylab.podspec"],
            "from": "skylab_version = \".*\"",
            "to": "skylab_version = \"${nextRelease.version}\"",
            "results": [
              {
                "file": "AmplitudeSkylab.podspec",
                "hasChanged": true,
                "numMatches": 1,
                "numReplacements": 1
              }
            ],
            "countMatches": true
          },
          {
            "files": ["Sources/Skylab/SkylabConfig.swift"],
            "from": "Version: String = \".*\"",
            "to": "Version: String = \"${nextRelease.version}\"",
            "results": [
              {
                "file": "Sources/Skylab/SkylabConfig.swift",
                "hasChanged": true,
                "numMatches": 1,
                "numReplacements": 1
              }
            ],
            "countMatches": true
          },
        ]
      }
    ],
    ["@semantic-release/git", {
      "assets": ["AmplitudeSkylab.podspec", "Sources/Skylab/SkylabConfig.swift", "CHANGELOG.md", "docs/*"],
      "message": "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}"
    }],
    ["@semantic-release/exec", {
      "publishCmd": "pod trunk push AmplitudeSkylab.podspec",
    }],
  ],
}
