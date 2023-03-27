import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:collection/collection.dart';

class IosArCamera extends StatefulWidget {
  @override
  _IosArCameraState createState() => _IosArCameraState();
}

class _IosArCameraState extends State<IosArCamera> {
  late ARKitController arkitController;
  ARKitReferenceNode? node;
  ARKitNode? boxNode;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Custom object on plane Sample')),
        body: Container(
          child: ARKitSceneView(
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: onARKitViewCreated,
            showFeaturePoints: false,
            enablePanRecognizer: true,
            enableRotationRecognizer: true,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);
    arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onNodePinch = (pinch) => _onPinchHandler(pinch);
    this.arkitController.onNodePan = (pan) => _onPanHandler(pan);
    this.arkitController.onNodeRotation =
        (rotation) => _onRotationHandler(rotation);
  }

  void _onPinchHandler(List<ARKitNodePinchResult> pinch) {
    final pinchNode = pinch.firstWhereOrNull(
      (e) => e.nodeName == boxNode?.name,
    );
    if (pinchNode != null) {
      final scale = vector.Vector3.all(pinchNode.scale);
      boxNode?.scale = scale;
    }
  }

  void _onPanHandler(List<ARKitNodePanResult> pan) {
    final panNode = pan.firstWhereOrNull((e) => e.nodeName == boxNode?.name);
    if (panNode != null) {
      final old = boxNode?.eulerAngles;
      final newAngleY = panNode.translation.x * math.pi / 180;
      boxNode?.eulerAngles =
          vector.Vector3(old?.x ?? 0, newAngleY, old?.z ?? 0);
    }
  }

  void _onRotationHandler(List<ARKitNodeRotationResult> rotation) {
    final rotationNode = rotation.firstWhereOrNull(
      (e) => e.nodeName == boxNode?.name,
    );
    if (rotationNode != null) {
      final rotation = boxNode?.eulerAngles ??
          vector.Vector3.zero() + vector.Vector3.all(rotationNode.rotation);
      boxNode?.eulerAngles = rotation;
    }
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      _addPlane(arkitController, anchor);
    }
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    if (node != null) {
      controller.remove(node!.name);
    }
    node = ARKitReferenceNode(
      url: 'models.scnassets/dash.dae',
      scale: vector.Vector3.all(0.3),
    );
    controller.add(node!, parentNodeName: anchor.nodeName);
  }
}
