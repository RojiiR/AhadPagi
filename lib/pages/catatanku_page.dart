import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CatatankuPage extends StatefulWidget {
  const CatatankuPage({super.key});

  @override
  State<CatatankuPage> createState() => _CatatankuPageState();
}

class _CatatankuPageState extends State<CatatankuPage> {
  final TextEditingController _noteController = TextEditingController();
  final List<Map<String, dynamic>> _notes = [];
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  final ImagePicker _picker = ImagePicker();
  String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImagePath = image.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil gambar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[600] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        'Pilih Sumber Gambar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.grey[300] : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00CED1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Color(0xFF00CED1),
                          ),
                        ),
                        title: Text(
                          'Kamera',
                          style: TextStyle(
                            color: isDark ? Colors.grey[300] : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Ambil foto baru',
                          style: TextStyle(
                            color: isDark ? Colors.grey[500] : Colors.grey[600],
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _pickImage(ImageSource.camera);
                        },
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00CED1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.photo_library,
                            color: Color(0xFF00CED1),
                          ),
                        ),
                        title: Text(
                          'Galeri',
                          style: TextStyle(
                            color: isDark ? Colors.grey[300] : Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Pilih dari galeri',
                          style: TextStyle(
                            color: isDark ? Colors.grey[500] : Colors.grey[600],
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _pickImage(ImageSource.gallery);
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getGreeting() {
    final hour = _currentTime.hour;
    final dayName = _getDayName(_currentTime.weekday);

    if (hour < 12) return '$dayName Pagi';
    if (hour < 15) return '$dayName Siang';
    if (hour < 18) return '$dayName Sore';
    return '$dayName Malam';
  }

  String _getDayName(int weekday) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Ahad'];
    return days[weekday - 1];
  }

  String _getHijriDate() {
    return '27 Sya\'ban 1446 H';
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }

  void _addNote() {
    if (_noteController.text.trim().isNotEmpty || _selectedImagePath != null) {
      setState(() {
        _notes.insert(0, {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'text': _noteController.text,
          'date': DateTime.now().toString().substring(0, 16),
          'imagePath': _selectedImagePath,
        });
        _noteController.clear();
        _selectedImagePath = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Catatan berhasil ditambahkan'),
          backgroundColor: Color(0xFF00CED1),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Catatan atau gambar tidak boleh kosong'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _editNote(int index) {
    _noteController.text = _notes[index]['text']!;
    _selectedImagePath = _notes[index]['imagePath'];

    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                'Edit Catatan',
                style: TextStyle(
                  color: isDark ? Colors.grey[300] : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _noteController,
                      maxLines: 4,
                      autofocus: true,
                      style: TextStyle(
                        color: isDark ? Colors.grey[300] : Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Edit catatan...',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.grey[500] : Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color:
                                isDark ? Colors.grey[600]! : Colors.grey[300]!,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFF00CED1),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Image preview and picker
                    if (_selectedImagePath != null)
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(_selectedImagePath!),
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                setDialogState(() {
                                  _selectedImagePath = null;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 10),

                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showImageSourceDialog();
                        // Re-open dialog after picking image
                        Future.delayed(const Duration(milliseconds: 500), () {
                          _editNote(index);
                        });
                      },
                      icon: const Icon(Icons.image),
                      label: Text(_selectedImagePath == null
                          ? 'Tambah Gambar'
                          : 'Ganti Gambar'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF00CED1),
                        side: const BorderSide(color: Color(0xFF00CED1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _noteController.clear();
                    _selectedImagePath = null;
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Batal',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_noteController.text.trim().isNotEmpty ||
                        _selectedImagePath != null) {
                      setState(() {
                        _notes[index]['text'] = _noteController.text;
                        _notes[index]['date'] =
                            DateTime.now().toString().substring(0, 16);
                        _notes[index]['imagePath'] = _selectedImagePath;
                      });
                      _noteController.clear();
                      _selectedImagePath = null;
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Catatan berhasil diupdate'),
                          backgroundColor: Color(0xFF00CED1),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00CED1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Simpan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteNote(int index) {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Hapus Catatan',
            style: TextStyle(
              color: isDark ? Colors.grey[300] : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus catatan ini?',
            style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.black87,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Batal',
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _notes.removeAt(index);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Catatan berhasil dihapus'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _showNoteDetails(int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[600] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Note content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image if exists
                      if (_notes[index]['imagePath'] != null)
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(_notes[index]['imagePath']!),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),

                      if (_notes[index]['text']!.isNotEmpty)
                        Text(
                          _notes[index]['text']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? Colors.grey[300] : Colors.black87,
                            height: 1.5,
                          ),
                        ),

                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: isDark ? Colors.grey[500] : Colors.grey[500],
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _notes[index]['date']!,
                            style: TextStyle(
                              fontSize: 13,
                              color:
                                  isDark ? Colors.grey[500] : Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _editNote(index);
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF00CED1),
                            side: const BorderSide(
                              color: Color(0xFF00CED1),
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteNote(index);
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text('Hapus'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.grey[50],
      body: Column(
        children: [
          // Header (sama seperti Beranda)
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF00CED1), Color(0xFF00B4B8)],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00CED1).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.note,
                            size: 35,
                            color: Color(0xFF00CED1),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Catatanku',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Catat ibadah dan kegiatan harianmu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _getGreeting(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${_currentTime.day} ${_getMonthName(_currentTime.month)} ${_currentTime.year}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      _getHijriDate(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Input Card
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: const Color(0xFF00CED1), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00CED1).withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _noteController,
                          maxLines: 4,
                          style: TextStyle(
                            color: isDark ? Colors.grey[300] : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Tulis catatan baru...',
                            hintStyle: TextStyle(
                              color:
                                  isDark ? Colors.grey[500] : Colors.grey[400],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Colors.grey[600]!
                                    : Colors.grey[300]!,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color(0xFF00CED1),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(15),
                          ),
                        ),

                        // Image preview
                        if (_selectedImagePath != null) ...[
                          const SizedBox(height: 12),
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(_selectedImagePath!),
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImagePath = null;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 12),

                        // Image picker button and Add button
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: _showImageSourceDialog,
                              icon: const Icon(Icons.image, size: 20),
                              label: const Text('Gambar'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF00CED1),
                                side: const BorderSide(
                                  color: Color(0xFF00CED1),
                                  width: 2,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _addNote,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00CED1),
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 3,
                                ),
                                child: const Text(
                                  'Tambah Catatan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Notes List
                  _notes.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.note_outlined,
                                size: 80,
                                color: isDark
                                    ? Colors.grey[700]
                                    : Colors.grey[300],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Belum ada catatan',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDark
                                      ? Colors.grey[500]
                                      : Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _notes.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border(
                                  left: BorderSide(
                                    color: const Color(0xFF00CED1),
                                    width: 4,
                                  ),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => _showNoteDetails(index),
                                  borderRadius: BorderRadius.circular(15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                _notes[index]['text']!,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: isDark
                                                      ? Colors.grey[300]
                                                      : Colors.grey[800],
                                                  height: 1.5,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            PopupMenuButton<String>(
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: isDark
                                                    ? Colors.grey[400]
                                                    : Colors.grey[600],
                                              ),
                                              color: isDark
                                                  ? const Color(0xFF2A2A2A)
                                                  : Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              onSelected: (value) {
                                                if (value == 'edit') {
                                                  _editNote(index);
                                                } else if (value == 'delete') {
                                                  _deleteNote(index);
                                                }
                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: 'edit',
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.edit,
                                                        size: 20,
                                                        color:
                                                            Color(0xFF00CED1),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                          color: isDark
                                                              ? Colors.grey[300]
                                                              : Colors.black87,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 'delete',
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                        color: Colors.red,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        'Hapus',
                                                        style: TextStyle(
                                                          color: isDark
                                                              ? Colors.grey[300]
                                                              : Colors.black87,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  size: 14,
                                                  color: isDark
                                                      ? Colors.grey[500]
                                                      : Colors.grey[500],
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  _notes[index]['date']!,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDark
                                                        ? Colors.grey[500]
                                                        : Colors.grey[500],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF00CED1)
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                'Tap untuk detail',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color:
                                                      const Color(0xFF00CED1),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
