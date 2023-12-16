import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Controller/getxcontroller.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:line_icons/line_icons.dart';
import '../view/drawer.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Uint8List? markIcons;
  String mapTheme = "";

  final Controller getxcontroller = Get.put<Controller>(Controller());
  TextEditingController sourceController = TextEditingController();
  String selectedRoute = "";

  late GoogleMapController googleMapController;
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 12,
  );
  var routes = [
    "--------------Select Default--------------",
    "Route 1:Railway station Lahore,Lahore Junction - Bhatti chowk Metro Bus Station ",
    "Route 2:Railway station Lahore,Lahore Junction - Shahdara Lari Adda",
    "Route 3:R.A. Bazar - Chungi Amar Sidhu",
    "Route 4:Shad Bagh Underpass,Bhamma Lahore - Bhatti chowk Metro Bus Station",
    "Route 5:Babu Sabu - Raj Garh Chowk",
    "Route 6:Bagrian - Chungi Amar Sidhu",
    "Route 7:Doctor Hospital - Canal",
    "Route 8:Railway Station - Sham Nagar",
    "Route 9:Multan Chungi - Qartaba Chowk",
    "Route 10:Babu Sabu - Main Market Gulberg",
    "Route 11:R.A Bazar - Civil Secretariat",
    "Route 12:Bagrian - Kalma Chowk",
    "Route 13:R.A Bazar - Chungi Amar Sidhu",
    "Route 14:Qartba Chowk - Babu Sabu",
    "Route 15:Railway Station - Bhatti Chowk",
    "Route 16:Canal - Railway Station",
    "Route 17:Bhatti Chowk - Shimla Pahari",
    "Route 18:Main Market - Bhatti Chowk",
    "Route 19:Jain Mandar - Chowk Yateem Khana",
    "Route 20:Depot Chowk - Thokar Niaz Baig",
    "Route 22:Depot Chowk - Thokar Niaz  Baig",
    "Route 23:Valencia - Thokar Niaz Baig",
    "Route 24:Multan Chungi - Ghazi Chowk",
    "Route 25:R.A Bazar - Railway Station",
    "Route 26:R.A Bazar - Daroghawala",
    "Route 27:BataPur - Daroghawala",
    "Route 28:Quaid e Azam Interchange - Airport",
    "Route 29:Niazi Interchange - Salamat Pura",
    "Route 30:Daroghawala - Airport",
    "Route 31:Daroghawala - Lari Adda",
    "Route 32:Shimla Pahari - Ek Moriya",
    "Route 33:Cooper Store - Mughalpura",
    "Route 34:Singhpura - Mughalpura",
  ];
  List<String> routeimages = [
    'images/bus-icon.png',
    'images/circle.png',
    'images/circle.png',
    'images/circle.png',
    'images/circle.png',
    'images/circle.png',
    'images/circle.png',
    'images/redpin.png',
  ];
  List<String> images = [
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
    'images/bus-icon.png',
  ];

  final List<LatLng> route = <LatLng>[
    const LatLng(31.584579, 74.308431), // Railways Station
    const LatLng(31.538932, 74.312102), // Ek Moriya
    const LatLng(31.526152, 74.322574), // Nawaz Sharif Hospital
    const LatLng(31.572677, 74.309865), // Kashmiri Gate
    const LatLng(31.584591, 74.326986), // Lari Adda
    const LatLng(31.5888998, 74.3065506), // Azadi Chowk
    const LatLng(31.54972, 74.34361), // Texali Chowk
    const LatLng(31.529702, 74.347287), // Bhaati Chowk
  ];
  final List<LatLng> route2 = <LatLng>[
    const LatLng(31.584579, 74.308431), // Railways Station
    const LatLng(31.538932, 74.312102), // Ek Moriya
    const LatLng(31.572677, 74.309865), // Kashmiri Gate
    const LatLng(31.584591, 74.326986), // Lari Adda
    const LatLng(31.5914, 74.3063), //azadi chowkk
    const LatLng(31.6001, 74.3008),
    const LatLng(31.6020, 74.2994),
    const LatLng(31.6196, 74.2899), // shahdara lari adda
  ];

  final List<LatLng> stop = <LatLng>[
    const LatLng(31.584579, 74.308431), // Railways Station
    const LatLng(31.529702, 74.347287), // Bhaati Chowk
    const LatLng(31.538932, 74.312102), // samnabad Mor
    const LatLng(31.584591, 74.326986), // shahdara lara adda
    const LatLng(31.572677, 74.309865), //RA bAZAR
    const LatLng(31.584579, 74.308431), // Chungi Amr Sandhu
    const LatLng(31.600211, 74.354160), // Shad bagh underpass
    const LatLng(31.6143, 74.2240), // Babu sabu
    const LatLng(31.4797, 74.2804), // Doctor hospital
    const LatLng(31.4961, 74.2641), // Multan chungi
    const LatLng(31.5241, 74.3467), // Main Market Gulberg
    const LatLng(31.503818, 74.331823), // Kalma chowk
    const LatLng(31.5476, 74.3157), // Qartaba chowk
    const LatLng(31.5623, 74.3358), // Shemla pahari
    const LatLng(31.5322, 74.2872), // chowk yateem khana
    const LatLng(31.4914, 74.2385), // Thokar Niaz Baigh
    const LatLng(31.4032, 74.2560), // valencia
    const LatLng(31.4367, 74.2911), // Ghazi Chowk
    const LatLng(31.5817, 74.34361), // Darogay wala
    const LatLng(31.5690, 74.3586), // Mughal Pura
    const LatLng(31.5794, 74.3749), // singhpura
    const LatLng(31.6040, 74.2996), // NiaziInterchange
    const LatLng(31.5928, 74.4262), // salamat pura
    const LatLng(31.5915, 74.4716), // BataPur
  ];

  Future<Uint8List> getMarkerIcon(String imagepath, int width) async {
    final ByteData data = await rootBundle.load(imagepath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Widget buildCupertinoTextFieldForSource() {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Container(
        width: Get.width,
        height: 50,
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Select Your Route'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: routes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(routes[index]),
                          onTap: () async {
                            Navigator.of(context).pop();
                            selectedRoute = routes[index];
                            if (selectedRoute == routes[0]) {
                              sourceController.text = selectedRoute;
                              stopMarker();
                            } else if (selectedRoute == routes[1]) {
                              sourceController.text = selectedRoute;
                              routeMarker();
                            } else if (selectedRoute == routes[2]) {
                              sourceController.text = selectedRoute;
                              routeMarker2();
                            } else {
                              sourceController.text = selectedRoute;
                              clearmarker();
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Select Your Route'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: routes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(routes[index]),
                            onTap: () async {
                              Navigator.of(context).pop();
                              selectedRoute = routes[index];
                              if (selectedRoute == routes[0]) {
                                sourceController.text = selectedRoute;
                                stopMarker();
                              } else if (selectedRoute == routes[1]) {
                                sourceController.text = selectedRoute;
                                routeMarker();
                              } else if (selectedRoute == routes[2]) {
                                sourceController.text = selectedRoute;
                                routeMarker2();
                              } else {
                                sourceController.text = selectedRoute;
                                clearmarker();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
            child: TextFormField(
              controller: sourceController,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  LineIcons.mapPin,
                  color: Colors.black,
                  size: 18,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Your Route'),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: ListView.builder(
                              itemCount: routes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(routes[index]),
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                    selectedRoute = routes[index];
                                    if (selectedRoute == routes[0]) {
                                      sourceController.text = selectedRoute;
                                      stopMarker();
                                    } else if (selectedRoute == routes[1]) {
                                      sourceController.text = selectedRoute;
                                      routeMarker();
                                    } else if (selectedRoute == routes[2]) {
                                      sourceController.text = selectedRoute;
                                      routeMarker2();
                                    } else {
                                      sourceController.text = selectedRoute;
                                      clearmarker();
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    LineIcons.locationArrow,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
                hintText: 'Choose Your Route',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffA7A7A7),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearmarker() async {
    getxcontroller.markers.clear();
    setState(() {});
  }

  routeMarker() async {
    getxcontroller.markers.clear();

    for (int i = 0; i < route.length - 1; i++) {
      final Uint8List markerIcon = await getMarkerIcon(routeimages[i], 60);
      getxcontroller.markers.add(
        Marker(
          markerId: MarkerId("location_$i"),
          position: route[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: "Route Stop $i",
          ),
        ),
      );
    }

    setState(() {});
  }

  routeMarker2() async {
    getxcontroller.markers.clear();
    getxcontroller.polyline.clear();

    for (int i = 0; i < route2.length - 1; i++) {
      final Uint8List markerIcon = await getMarkerIcon(routeimages[i], 60);
      getxcontroller.markers.add(
        Marker(
          markerId: MarkerId("location_$i"),
          position: route2[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: "Route Stop $i",
          ),
        ),
      );
    }

    setState(() {});
  }

  stopMarker() async {
    for (int i = 0; i < stop.length; i++) {
      final Uint8List markerIcon = await getMarkerIcon(images[i], 60);
      getxcontroller.markers.add(
        Marker(
          markerId: MarkerId("location_$i"),
          position: stop[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: "Location $i",
          ),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    stopMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Appdrawer(),
      appBar: AppBar(
        title: Text(
          'Tracking',
          style: GoogleFonts.getFont('Lato'),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  String mapStyle = await DefaultAssetBundle.of(context)
                      .loadString("Map_style/Silver_theme.json");
                  googleMapController.setMapStyle(mapStyle);
                },
                child: const Text('Silver'),
              ),
              PopupMenuItem(
                onTap: () async {
                  String mapStyle = await DefaultAssetBundle.of(context)
                      .loadString("Map_style/Retro_theme.json");
                  googleMapController.setMapStyle(mapStyle);
                },
                child: const Text('Retro'),
              ),
              PopupMenuItem(
                onTap: () async {
                  String mapStyle = await DefaultAssetBundle.of(context)
                      .loadString("Map_style/night_theme.json");
                  googleMapController.setMapStyle(mapStyle);
                },
                child: const Text('Night'),
              ),
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            myLocationEnabled: true,
            trafficEnabled: true,
            buildingsEnabled: true,
            indoorViewEnabled: true,
            markers: Set<Marker>.from(getxcontroller.markers),
            polylines: Set<Polyline>.from(getxcontroller.polyline),
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(mapTheme);
              googleMapController = controller;
            },
          ),
          buildCupertinoTextFieldForSource(),
        ],
      ),
    );
  }
}
