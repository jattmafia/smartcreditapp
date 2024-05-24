import 'dart:async';
import 'dart:convert';
import 'package:smartcredit/config.dart';
import 'package:smartcredit/navigator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartcredit/controller/drivercontroller.dart';
import 'package:socket_io_client/socket_io_client.dart';

class DriverScreen extends StatefulWidget {
  var lat, long;
  DriverScreen({super.key, required this.lat, required this.long});

  @override
  State<DriverScreen> createState() => MapSampleState();
}

class MapSampleState extends State<DriverScreen> {
  final controller = Get.put(DriverController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  var data;

  IO.Socket? socket;
  late CameraPosition? _kGooglePlex = CameraPosition(
    target: LatLng(widget.lat, widget.long),
    zoom: 14.4746,
  );
  @override
  void initState() {
    data = {"latitude": widget.lat, "longitude": widget.long};

    setState(() {});
    // TODO: implement initState
    get();

    super.initState();
  }

  get() async {
    //  _kGooglePlex = CameraPosition(
    //   target: LatLng(widget.driver["latitude"], widget.driver["longitude"]),
    //   zoom: 14.4746,
    // );
    // setState(() {

    // });

    socket = IO.io(
        "$SOCKET_URL", OptionBuilder().setTransports(['websocket']).build());
    socket!.connect();
    socket!.onConnect((_) {
      print('Connection established');
    });

    socket!.onError((err) => print(err));

    socket!.on("locationUpdate${controller.selectedid}",
        (dataa) => {print(dataa), data = dataa, mapupdate()});
  }

  mapupdate() async {
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 14.5,
          target: LatLng(
            double.parse(data["latitude"].toString()),
            double.parse(data["longitude"].toString()),
          ),
        ),
      ),
    );
    setState(() {});
    // setState(() {

    // });
  }

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              markers: {
                Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: LatLng(
                      double.parse(data["latitude"].toString()),
                      double.parse(data["longitude"].toString()),
                    ),
                    icon: controller.markerIcon),
              },
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
                top: 10,
                left: 10,
                child: BackButton(
                  onPressed: () {
                    socket!.disconnect();
                    socket!.dispose();

                    back(context);
                  },
                ))
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: const Text('To the lake!'),
        //   icon: const Icon(Icons.directions_boat),
        // ),
      ),
    );
  }

  // Future<void> _goToTheLake() async {

  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
