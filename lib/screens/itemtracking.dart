import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ItemTrackingScreen extends StatefulWidget {
  const ItemTrackingScreen({super.key});

  @override
  _ItemTrackingScreenState createState() => _ItemTrackingScreenState();
}

class _ItemTrackingScreenState extends State<ItemTrackingScreen> {
  late GoogleMapController _mapController;
  final Location _location = Location();
  late LatLng _currentPosition;
  bool _notificationsEnabled = false;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _getCurrentLocation();
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _getCurrentLocation() async {
    final LocationData locationData = await _location.getLocation();
    setState(() {
      _currentPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
    });
  }

  Future<void> _sendNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'item_tracking_channel_id',
      'Item Tracking Notifications',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Tracking'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: {
                Marker(
                  markerId: const MarkerId('current_position'),
                  position: _currentPosition,
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _getCurrentLocation();
                    _mapController.animateCamera(
                      CameraUpdate.newLatLng(_currentPosition),
                    );
                    if (_notificationsEnabled) {
                      await _sendNotification(
                        'Location Updated',
                        'The map has been updated to show your current location.',
                      );
                    }
                  },
                  child: const Text('Update GPS'),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Enable Push Notifications'),
                    Switch(
                      value: _notificationsEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
