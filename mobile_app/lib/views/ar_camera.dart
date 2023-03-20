// ignore_for_file: unnecessary_this, depend_on_referenced_packages
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArCamera extends StatefulWidget {
  const ArCamera({Key? key}) : super(key: key);
  @override
  ArCameraState createState() => ArCameraState();
}

class ArCameraState extends State<ArCamera> {
  // AR variables
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARNode? node;
  ARAnchor? anchor;
  ARNode? newNode;
  // True to show loader
  bool showLoader = false;
  double yRotationValue = 0.0;
  bool imageTaken = false;
  MemoryImage? image;
  String object3DName =
      "https://raw.githubusercontent.com/YACOUBI-Abdelhakime/Glb/master/coffee.glb";
  double objectScale = 1;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  bool isObjectAdded() {
    return anchor != null;
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          showWorldOrigin: false,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onNodeTap = onNodeTapped;
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
      (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane,
    );
    // Start loader
    setState(() {
      this.showLoader = true;
    });
    // Delete old object to add new one
    this.onRemoveObject();
    var newAnchor =
        ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
    bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
    if (didAddAnchor!) {
      this.anchor = newAnchor;
      // Add node to anchor
      this.newNode = ARNode(
        type: NodeType.webGLB,
        uri: object3DName,
        scale: vector.Vector3(objectScale, objectScale, objectScale),
        position: vector.Vector3(0.0, 0.0, 0.0),
        rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0),
      );
      bool? didAddNodeToAnchor =
          await this.arObjectManager!.addNode(newNode!, planeAnchor: newAnchor);
      if (didAddNodeToAnchor!) {
        this.node = newNode;
      } else {
        this.arSessionManager!.onError("Adding Node to Anchor failed");
      }
    } else {
      this.arSessionManager!.onError("Adding Anchor failed");
    }
    // Stop loader
    setState(() {
      this.showLoader = false;
    });
  }

  Future<void> onNodeTapped(List<String> nodes) async {}

  Future<void> onRemoveObject() async {
    if (anchor != null && this.node != null) {
      this.arAnchorManager!.removeAnchor(this.anchor!);
      this.arObjectManager!.removeNode(this.node!);
      setState(() {
        anchor = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          if (this.isObjectAdded()) ...[
            Align(
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  width: MediaQuery.of(context).size.width - 20,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Delete object
                          ElevatedButton(
                            onPressed: this.onRemoveObject,
                            child: const Text("Supprimer"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          if (this.showLoader) ...[
            Align(
              alignment: FractionalOffset.center,
              child: Container(
                width: 70,
                height: 70,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 8,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
