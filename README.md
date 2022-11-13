# dreavy

### Usage
This project aims to create a platform where users can share their photos with everyone.
The project is accessible on wen and mobile. All you have to do is first create an account, and then simply open your camera, take a picture and share it instantly.
Access the pictures of every user around the world !

### Requirements
To run this project, you need to install **android sdk** and the latest stable [flutter sdk](https://docs.flutter.dev/get-started/install?gclid=Cj0KCQiApb2bBhDYARIsAChHC9uypcGndvutpennvR2yDgqYP7iu4k5tKLttLoxF09pffqOBWr8OaywaAlaYEALw_wcB&gclsrc=aw.ds/)
Then you can launch **dreavy** following these steps:
``` bash
# Clone this repository
$ git clone https://github.com/nautiii/dreavy

# Go into the repository
$ cd dreavy

# To build the project
$ flutter pub get && flutter build

# Run on mobile
$ flutter run

# Run on web
$ flutter run -d web

```

### Architecture
For this project, we used [**provider pattern**](https://pub.dev/packages/provider) to handle app state, with **repository patterns** to organize the file tree
All data structures are stored in the **models** directory, and used by providers inside the **providers** directory. All the visual stuff is organized inside the **ui** folder.
User and data handling are managed by [**Cloud Firestore**](https://firebase.google.com/products/firestore).

### Dependencies
> _All mentioned packages are stored on the official [**pub.dev**](https://pub.dev) platform_

The packages used to develop this application are:
* **Handle native camera of phone and pc**: camera, image_picker
* **Handle users data and connection**: firebase_core, cloud_firestore, encrypt
* **Get the file path for pictures**: path, path_provider
* **Handle routing inside the app**: go_router
* **Handle internal app and widgets state**: provider

### Authors
* Quentin MAILLARD
* Thomas BODA