import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OperatingHours {
  final TimeOfDay openTime;
  final TimeOfDay closeTime;
  final bool isOpen;

  const OperatingHours({
    required this.openTime,
    required this.closeTime,
    this.isOpen = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'openTime': '${openTime.hour}:${openTime.minute}',
      'closeTime': '${closeTime.hour}:${closeTime.minute}',
      'isOpen': isOpen,
    };
  }

  factory OperatingHours.fromJson(Map<String, dynamic> json) {
    return OperatingHours(
      openTime: TimeOfDay(
        hour: int.parse(json['openTime'].split(':')[0]),
        minute: int.parse(json['openTime'].split(':')[1]),
      ),
      closeTime: TimeOfDay(
        hour: int.parse(json['closeTime'].split(':')[0]),
        minute: int.parse(json['closeTime'].split(':')[1]),
      ),
      isOpen: json['isOpen'] as bool,
    );
  }

  OperatingHours copyWith({
    TimeOfDay? openTime,
    TimeOfDay? closeTime,
    bool? isOpen,
  }) {
    return OperatingHours(
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}

class SetOperationHoursScreen extends StatefulWidget {
  final Map<String, OperatingHours>? initialHours;

  const SetOperationHoursScreen({Key? key, this.initialHours}) : super(key: key);

  @override
  State<SetOperationHoursScreen> createState() => _SetOperationHoursScreenState();
}

class _SetOperationHoursScreenState extends State<SetOperationHoursScreen> {
  late Map<String, OperatingHours> _operatingHours;
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final Map<String, Map<String, OperatingHours>> _operatingHoursTemplates = {
    'Standard Evening Hours': {
      'Monday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: true),
      'Tuesday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: true),
      'Wednesday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: true),
      'Thursday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: true),
      'Friday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: true),
      'Saturday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: true),
      'Sunday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: true),
    },
    'Weekend Only': {
      'Monday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: false),
      'Tuesday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: false),
      'Wednesday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: false),
      'Thursday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: false),
      'Friday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: true),
      'Saturday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 3, minute: 0),
          isOpen: true),
      'Sunday': OperatingHours(
          openTime: TimeOfDay(hour: 16, minute: 0),
          closeTime: TimeOfDay(hour: 2, minute: 0),
          isOpen: true),
    },
    'Late Night Hours': {
      'Monday': OperatingHours(
          openTime: TimeOfDay(hour: 20, minute: 0),
          closeTime: TimeOfDay(hour: 4, minute: 0),
          isOpen: true),
      'Tuesday': OperatingHours(
          openTime: TimeOfDay(hour: 20, minute: 0),
          closeTime: TimeOfDay(hour: 4, minute: 0),
          isOpen: true),
      'Wednesday': OperatingHours(
          openTime: TimeOfDay(hour: 20, minute: 0),
          closeTime: TimeOfDay(hour: 4, minute: 0),
          isOpen: true),
      'Thursday': OperatingHours(
          openTime: TimeOfDay(hour: 20, minute: 0),
          closeTime: TimeOfDay(hour: 4, minute: 0),
          isOpen: true),
      'Friday': OperatingHours(
          openTime: TimeOfDay(hour: 20, minute: 0),
          closeTime: TimeOfDay(hour: 5, minute: 0),
          isOpen: true),
      'Saturday': OperatingHours(
          openTime: TimeOfDay(hour: 20, minute: 0),
          closeTime: TimeOfDay(hour: 5, minute: 0),
          isOpen: true),
      'Sunday': OperatingHours(
          openTime: TimeOfDay(hour: 20, minute: 0),
          closeTime: TimeOfDay(hour: 4, minute: 0),
          isOpen: true),
    },
  };

  @override
  void initState() {
    super.initState();
    _operatingHours = widget.initialHours?.map(
          (key, value) => MapEntry(key, value),
        ) ??
        {
          'Monday': OperatingHours(
            openTime: const TimeOfDay(hour: 16, minute: 0),
            closeTime: const TimeOfDay(hour: 2, minute: 0),
            isOpen: true,
          ),
          'Tuesday': OperatingHours(
            openTime: const TimeOfDay(hour: 16, minute: 0),
            closeTime: const TimeOfDay(hour: 2, minute: 0),
            isOpen: true,
          ),
          'Wednesday': OperatingHours(
            openTime: const TimeOfDay(hour: 16, minute: 0),
            closeTime: const TimeOfDay(hour: 2, minute: 0),
            isOpen: true,
          ),
          'Thursday': OperatingHours(
            openTime: const TimeOfDay(hour: 16, minute: 0),
            closeTime: const TimeOfDay(hour: 2, minute: 0),
            isOpen: true,
          ),
          'Friday': OperatingHours(
            openTime: const TimeOfDay(hour: 16, minute: 0),
            closeTime: const TimeOfDay(hour: 2, minute: 0),
            isOpen: true,
          ),
          'Saturday': OperatingHours(
            openTime: const TimeOfDay(hour: 16, minute: 0),
            closeTime: const TimeOfDay(hour: 2, minute: 0),
            isOpen: true,
          ),
          'Sunday': OperatingHours(
            openTime: const TimeOfDay(hour: 16, minute: 0),
            closeTime: const TimeOfDay(hour: 2, minute: 0),
            isOpen: true,
          ),
        };
  }

  Future<TimeOfDay?> _selectTime(BuildContext context, TimeOfDay initialTime) async {
    return showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
  }

  void _applyTemplate(String templateName) {
    final template = _operatingHoursTemplates[templateName];
    if (template != null) {
      setState(() {
        _operatingHours = Map.from(template);
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Operating Hours'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _applyTemplate,
            itemBuilder: (BuildContext context) {
              return _operatingHoursTemplates.keys.map((String template) {
                return PopupMenuItem<String>(
                  value: template,
                  child: Text(template),
                );
              }).toList();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _daysOfWeek.length,
        itemBuilder: (context, index) {
          final day = _daysOfWeek[index];
          final hours = _operatingHours[day]!;

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        day,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: hours.isOpen,
                        onChanged: (bool value) {
                          setState(() {
                            _operatingHours[day] = hours.copyWith(isOpen: value);
                          });
                        },
                      ),
                    ],
                  ),
                  if (hours.isOpen) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Opening Time'),
                            TextButton(
                              onPressed: () async {
                                final TimeOfDay? newTime = await _selectTime(
                                  context,
                                  hours.openTime,
                                );
                                if (newTime != null) {
                                  setState(() {
                                    _operatingHours[day] =
                                        hours.copyWith(openTime: newTime);
                                  });
                                }
                              },
                              child: Text(_formatTimeOfDay(hours.openTime)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Closing Time'),
                            TextButton(
                              onPressed: () async {
                                final TimeOfDay? newTime = await _selectTime(
                                  context,
                                  hours.closeTime,
                                );
                                if (newTime != null) {
                                  setState(() {
                                    _operatingHours[day] =
                                        hours.copyWith(closeTime: newTime);
                                  });
                                }
                              },
                              child: Text(_formatTimeOfDay(hours.closeTime)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _operatingHours);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Save Operating Hours'),
        ),
      ),
    );
  }
}
