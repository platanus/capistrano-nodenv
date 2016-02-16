# master (unreleased)

* Change default `nodenv_path` to use `$HOME` instead of `~`. This allows
  capistrano-nodenv to work with the new quoting behavior of sshkit 1.8.0.

# 1.0.0

* Added ability to setup custom `nodenv_roles` variable (default: :all).
