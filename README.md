# Drupal Demo

This demo installs Drupal to Stackato by using 'drush' in post-staging
hooks. Very little code is pushed by the client, just the scripts used
to configure Drupal on Stackato. The stackato.yml file shows how these
are run, and demonstrates the use of the filesystem service for sharing
user content, themes and modules between application instances.

The 'sites' directory tree is linked to a single mounted filesystem
service, but you can set these up on multiple filesystem services (e.g.
if you wish to share 'sites/all' between multiple sites).

## Deploying to Stackato

    stackato push -n


Information on configuring and using Drupal can be found at:

 http://drupal.org/