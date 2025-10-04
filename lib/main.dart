import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Slider App'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Show a dialog or any other widget when the settings icon is pressed
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Ayarlar'),
                  content: Text('Lütfen...'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Tamam'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImageSliderScreen()),
            );
          },
          child: Text('Proceed to create a presentation'),
        ),
      ),
    );
  }
}

class ImageSliderScreen extends StatefulWidget {
  const ImageSliderScreen({super.key});

  @override
  _ImageSliderScreenState createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<Uint8List> _images = [];
  final List<int> _intervals = [];
  final List<String> _animations = [];
  int _currentIndex = 0;
  bool _isSliding = false;
  int _countdown = 0;
  Timer? _timer;
  bool _isShuffle = false;
  TextEditingController _durationController =
      TextEditingController(); // Süre giriş için controller
  Timer? _workTimer; // Çalışma süresi timer'ı

  Future<void> _pickImages() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      List<Uint8List> pickedFiles = [];
      for (var file in pickedImages) {
        final bytes = await file.readAsBytes();
        pickedFiles.add(bytes);
        _intervals.add(2); // Default interval 2 seconds
        _animations.add('fade'); // Default animation 'fade'
      }
      setState(() {
        _images.addAll(pickedFiles);
        _currentIndex = 0;
        _countdown = _intervals[_currentIndex];
      });
    }
  }

  void _startSlider() {
    if (_images.isEmpty || _isSliding) return;

    setState(() {
      _isSliding = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _currentIndex = (_currentIndex + 1) % _images.length;
          _countdown = _intervals[_currentIndex];
        }
      });
    });
  }

  void _stopSlider() {
    setState(() {
      _isSliding = false;
    });
    _timer?.cancel();
  }

  void _shuffleImages() {
    setState(() {
      _isShuffle = !_isShuffle;
      if (_isShuffle) {
        _images.shuffle();
        _intervals.shuffle();
        _animations.shuffle();
      } else {
        _images.sort((a, b) => a.hashCode.compareTo(b.hashCode));
        _intervals.sort();
        _animations.sort();
      }
    });
  }

  Widget _getAnimatedImage(int index) {
    Widget imageWidget = Image.memory(
      _images[index],
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );

    switch (_animations[index]) {
      case 'fade':
        imageWidget = FadeTransition(
          opacity: AlwaysStoppedAnimation(1.0),
          child: imageWidget,
        );
        break;
      case 'slide':
        imageWidget = SlideTransition(
          position: AlwaysStoppedAnimation(Offset(0.0, 0.0)),
          child: imageWidget,
        );
        break;
      case 'zoom':
        imageWidget = ScaleTransition(
          scale: AlwaysStoppedAnimation(1.0),
          child: imageWidget,
        );
        break;
      default:
        break;
    }

    return imageWidget;
  }

  Future<void> _saveImages() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Images Saved!")));
  }

  void _clearImages() {
    setState(() {
      _images.clear();
      _intervals.clear();
      _animations.clear();
    });
  }

  // Kullanıcıdan süre alıp timer başlatma
  void _startWorkTimer() {
    final duration = int.tryParse(_durationController.text);

    if (duration != null && duration > 0) {
      _workTimer = Timer(Duration(seconds: duration), () {
        // Çalışma süresi bitince ana menüye dön
        Navigator.pop(context);
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Çalışma süresi başladı! $duration saniye sonra ana menüye döneceksiniz."),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Lütfen geçerli bir süre girin."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.pop(context); // Çift tıklama ile ana menüye dönüş
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Image Slider')),
        body: Stack(
          children: [
            if (_images.isEmpty) // Eğer resimler seçilmediyse göster
              Center(
                child: LinearProgressIndicator(
                  value:
                      0.5, // Burada değeri dinamik olarak güncelleyebilirsiniz
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Add the new code here
                if (_images.isEmpty)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hoş geldiniz! Hadi, sunumunuzu oluşturmaya başlayalım.",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _pickImages,
                          child: Text('Resim Seçin'),
                        ),
                        SizedBox(height: 20),
                        // Süreyi almak için TextField
                        TextField(
                          controller: _durationController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Çalışma Süresi (saniye)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _startWorkTimer,
                          child: Text('Çalışma Süresini Başlat'),
                        ),
                      ],
                    ),
                  ),
                if (_images.isNotEmpty)
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ReorderableListView(
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                final image = _images.removeAt(oldIndex);
                                final interval = _intervals.removeAt(oldIndex);
                                final animation =
                                    _animations.removeAt(oldIndex);
                                _images.insert(newIndex, image);
                                _intervals.insert(newIndex, interval);
                                _animations.insert(newIndex, animation);
                              });
                            },
                            children: List.generate(_images.length, (index) {
                              return ListTile(
                                key: ValueKey<int>(index),
                                title: Row(
                                  children: [
                                    Image.memory(
                                      _images[index],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Interval: ${_intervals[index]} sec'),
                                    IconButton(
                                      icon: Icon(Icons.timer),
                                      onPressed: () async {
                                        int? newInterval =
                                            await showDialog<int>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Set Interval'),
                                            content: Slider(
                                              min: 1,
                                              max: 10,
                                              divisions: 9,
                                              value:
                                                  _intervals[index].toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _intervals[index] =
                                                      value.toInt();
                                                });
                                              },
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context,
                                                      _intervals[index]);
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (newInterval != null) {
                                          setState(() {
                                            _intervals[index] = newInterval;
                                          });
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.animation),
                                      onPressed: () async {
                                        String? newAnimation =
                                            await showDialog<String>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Select Animation'),
                                            content: DropdownButton<String>(
                                              value: _animations[index],
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _animations[index] =
                                                      newValue!;
                                                });
                                                Navigator.pop(
                                                    context, newValue);
                                              },
                                              items: <String>[
                                                'fade',
                                                'slide',
                                                'zoom'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                        if (newAnimation != null) {
                                          setState(() {
                                            _animations[index] = newAnimation;
                                          });
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          _images.removeAt(index);
                                          _intervals.removeAt(index);
                                          _animations.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.shuffle),
                              onPressed: _shuffleImages,
                            ),
                            IconButton(
                              icon: Icon(Icons.save),
                              onPressed: _saveImages,
                            ),
                            IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: _clearImages,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (_isSliding)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _getAnimatedImage(_currentIndex),
                        SizedBox(height: 20),
                        Text('Next in: $_countdown seconds'),
                      ],
                    ),
                  ),
                if (!_isSliding && _images.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _startSlider,
                        child: Text('Start'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _stopSlider,
                        child: Text('Stop'),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
