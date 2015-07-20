#! /bin/bash

set -euo pipefail

if [ "$#" != 1 ]; then
  echo "usage: $0 terms|privacy" >&2;
  exit 1
fi

if [ "$1" = "terms" ]; then
  CLASS="terms"
  TITLE="Terms of Service"
elif [ "$1" = "privacy" ]; then
  CLASS="privacy"
  TITLE="Privacy Policy"
else
  echo "usage: $0 terms|privacy" >&2;
  exit 1
fi

cat << __EOF__
<!DOCTYPE html>
<html>
  <head>
    <title>Sandstorm Oasis: $TITLE</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript">
      function showTerms() {
        document.body.className = "terms";
        if (history.replaceState) {
          history.replaceState({}, "Sandstorm Oasis: Terms of Service", "/terms");
        } else {
          document.title = "Sandstorm Oasis: Terms of Service";
        }
      }
      function showPrivacy() {
        document.body.className = "privacy";
        if (history.replaceState) {
          history.replaceState({}, "Sandstorm Oasis: Privacy Policy", "/privacy");
        } else {
          document.title = "Sandstorm Oasis: Privacy Policy";
        }
      }
    </script>
    <style type="text/css">
__EOF__

cat style.css

cat << __EOF__
    </style>
  </head>
  <body class="$CLASS">
    <section id="overview">
__EOF__

markdown overview.md

cat << __EOF__
    </section>
    <section id="terms" onclick="showTerms()">
__EOF__

markdown tos.md

cat << __EOF__
    </section>
    <section id="privacy" onclick="showPrivacy()">
__EOF__

markdown privacy.md

cat << __EOF__
    </section>
  </body>
</html>
__EOF__

