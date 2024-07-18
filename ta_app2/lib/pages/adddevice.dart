import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final MqttServerClient client = MqttServerClient('mqtt.example.com', '');

  @override
  void initState() {
    super.initState();
    _connectToMqtt();
  }

  Future<void> _connectToMqtt() async {
    client.logging(on: true);
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;
    client.onSubscribeFail = _onSubscribeFail;
    client.onUnsubscribed = _onUnsubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .startClean()
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
  }

  void _onConnected() {
    print('Connected');
    client.subscribe('devices/wemos1/commands', MqttQos.atMostOnce);
  }

  void _onDisconnected() {
    print('Disconnected');
  }

  void _onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

  void _onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  void _onUnsubscribed(String? topic) {
    print('Unsubscribed topic: $topic');
  }

  void _addDevice() {
    print('Add Device button pressed');
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      const pubTopic = 'devices/wemos1/commands';
      final builder = MqttClientPayloadBuilder();
      builder.addString('connect');
      client.publishMessage(pubTopic, MqttQos.atMostOnce, builder.payload!);
    } else {
      print('MQTT client is not connected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Text('Hiponik'),
              SizedBox(width: 4),
              Image.asset(
                'assets/other/datang.png',
                width: 40,
                height: 40,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: Divider(
              height: 20.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 1),
            child: Center(
              child: Image.asset(
                'assets/other/sensor.png',
                width: 170,
                height: 180,
              ),
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Kamu mempunyai perangkat ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Tambahkan perangkatmu lalu mulai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Sensor Kontrol.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 200),
          Container(
            margin: EdgeInsets.only(bottom: 20.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: _addDevice,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Add Device',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
