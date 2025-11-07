import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/normPFCDTO.dart';
import '../services/normPFC.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';

class NormPFCScreen extends StatefulWidget{
  final String token;

  const NormPFCScreen({super.key, required this.token});

  @override
  State<NormPFCScreen> createState() => _NormPFCScreen();
}

class _NormPFCScreen extends State<NormPFCScreen> {
  normPFCDTO? _normPFC;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _loadNormPFC();
  }

  Future<void> _loadNormPFC() async {
    final data = await getNormPFC(widget.token);
    setState(() {
      _normPFC = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_normPFC == null) {
        return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Center(child: Text("CalCul")),
      ),
      body: Column(children: [
        SizedBox(
          width: 200,
          height: 200,
          child:
        DashedCircularProgressBar.aspectRatio(
          aspectRatio: 1,
          valueNotifier: _valueNotifier,
          progress: 478,
          maxProgress: 670,
          corners: StrokeCap.butt,
          foregroundColor: Colors.blue,
          backgroundColor: const Color(0xffeeeeee),
          foregroundStrokeWidth: 36,
          backgroundStrokeWidth: 36,
          animation: true,
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (_, double value, __) => Text(
                '${value.toInt()}%',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 60
                ),
              ),
            ),
          ),
        )
        ),
      ]
      ),
    );
  }
}