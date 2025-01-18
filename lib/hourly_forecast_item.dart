import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String text;
  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
                    elevation: 7,
                    child:Container(
                      width: 100,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Column(
                        children: [
                          Text(time,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Icon(icon),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(text,
                          ),
                        ],
                      ),
                    ),
                  );
  }
}
