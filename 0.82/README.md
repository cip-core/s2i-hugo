# Source to Image (S2I) Hugo Images

This is an source to image (s2i) builder image to generate static website using [Hugo](http://www.gohugo.io) - a fast and modern static web site generator.

# Building the image on OpenShift

0. Pick a s2i name

```
$ export S2INAME="cip-s2i-hugo"
```

1. Build the image

```
$ oc new-build httpd:2.4~https://github.com/oip-core-mirrors/s2i-hugo --strategy=docker --name=$S2INAME
```

# Using the image to generate a static website

## Using content stored on your host

0. Pick a name

```
$ export APPNAME="mywebsite"
```

1. Create a binary build configuration

```
$ oc new-build --binary --image-stream $S2INAME --name $APPNAME
```

2. Then start the build using the following command. It will upload files from the local directory.

```
$ oc start-build -F $APPNAME --from-dir=.
```

3. Once a first image has been created, you can create an application based on it with:

```
$ oc new-app $APPNAME
```

4. Create a secured route to expose the app outside the cluster

```
$ oc create route edge --service=$APPNAME
```

You can now access you app using a browser. To get the URL, use the following command

```
$ oc get route -l app=$APPNAME
```

5. Deploying new code

After editing the code on your workstation, you can publish it using the same command used previously to build the initial version.

```
$ oc start-build -F $APPNAME --from-dir=.
```

6. Deleting the app

Should you want to delete the app and all resources automatically created by the commands in this tutorial, use the following:

```
$ oc delete all -l app=$APPNAME
```

Some critical content such as persistent volume claims, secrets, configuration maps, etc. will not be automatically deleted by the previous command.
To clean them as well, use the following command:

```
$ oc delete all,pvc,secret,cm -l app=$APPNAME
```
