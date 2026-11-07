# Samsung Tizen packaging notes

The repository currently deploys Nuvora Home as a static web app through GitHub Pages. On a Samsung TV, first open the Pages URL in the built-in TV browser and test Home Assistant connectivity and remote navigation.

A native Tizen TV package (.wgt) is a separate packaging step. It must be signed using a Samsung/Tizen certificate profile generated for the developer's TV environment. Do not commit the private signing profile or passwords. The web app source is kept platform-neutral so it can be wrapped as a Tizen Web Application after the TV's model year, Tizen version, and certificate workflow are confirmed.


## Build requirements
Samsung's official TV CLI documentation lists Tizen Studio, the Web CLI package, and a valid certificate profile as prerequisites. It documents `tizen build-web` followed by `tizen package -t wgt -s <profile>`. The helper scripts in this folder automate those two commands.
