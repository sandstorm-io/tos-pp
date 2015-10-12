#! /bin/bash

set -euo pipefail

usage() {
  echo "usage: $0 oasis|sandcats terms|privacy" >&2;
  exit 1
}

if [ "$#" != 2 ]; then
  usage
fi

if [ "$1" = "oasis" ] ; then
  PRODUCT="Oasis"
elif [ "$1" = "sandcats" ] ; then
  PRODUCT="Sandcats"
else
  usage
fi

PREFIX="$1"

if [ "$2" = "terms" ]; then
  CLASS="terms"
  TITLE="Terms of Service"
elif [ "$2" = "privacy" ]; then
  CLASS="privacy"
  TITLE="Privacy Policy"
else
  usage
fi

cat << __EOF__
<!DOCTYPE html>
<html>
  <head>
    <title>Sandstorm $PRODUCT: $TITLE</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript">
      function showTerms() {
        document.body.className = "terms";
        if (history.replaceState) {
          history.replaceState({}, "Sandstorm $PRODUCT: Terms of Service", "/terms");
        } else {
          document.title = "Sandstorm $PRODUCT: Terms of Service";
        }
      }
      function showPrivacy() {
        document.body.className = "privacy";
        if (history.replaceState) {
          history.replaceState({}, "Sandstorm $PRODUCT: Privacy Policy", "/privacy");
        } else {
          document.title = "Sandstorm $PRODUCT: Privacy Policy";
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

markdown "${PREFIX}-overview.md"

cat << __EOF__
    </section>
    <section id="terms" onclick="showTerms()">
__EOF__

markdown "${PREFIX}-tos.md"

cat << __EOF__
    </section>
    <section id="privacy" onclick="showPrivacy()">
__EOF__

markdown "${PREFIX}-privacy.md"

cat << __EOF__
    </section>
  </body>
</html>
__EOF__
