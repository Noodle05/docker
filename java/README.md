This is a minimum java 8 jre container image that based on
alpine (3.2).

Why another alpine based java 8 image?

1. Most of available alpine based java 8 images using jdk,
   but in many cases, only jre is required.
2. This image remove more unused files for server usage
   (libavplugin-53.so, jconsole and more). They are not using
   a lot space, but as a docker image, smaller means better.
3. This image will also install(replace) unlimited JCE policy
