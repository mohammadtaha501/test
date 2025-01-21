import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/stateManegment/DataModel.dart';
import 'package:untitled2/stateManegment/state.dart';

class DatingListScreen extends StatelessWidget {
  const DatingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InventoryBloc()..add(LoadData()),
      child: Scaffold(
        body: BlocBuilder<InventoryBloc,AppState>(
          builder: (context, state) {
            if(state is DataLoaded){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF6C63FF), // Purple background color
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Dating List',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Position the arrow at the start (left)
                              Align(
                                alignment: Alignment.topLeft,
                                child: Icon(Icons.arrow_back, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          // Search Bar
                          Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10),
                                prefixIcon: Icon(Icons.search, color: Colors.grey),
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
                                border: InputBorder.none, // Removes the default underline
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // List of Cards
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final RandomUser User = state.users[index];
                          return DatingCard(
                            title: "Not provided in API",
                            age: User.dob.age,
                            date: User.registered.date,
                            distance: "3KM form you",
                            location: "${User.location.street.name} ${User.location.state} ${User.location.city} ${User.location.country}",
                            name: "${User.name.title}${User.name.first}${User.name.last}",
                            profileImageUrl: User.picture.large,
                            time: "08:00 PM",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }else if(state is LoadingData){
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              );
            }else{
              return Center(child: Text("Something Went wrong Please check your Internet connectivity",style: TextStyle(fontSize: 16),));
            }
          },
        ),
      ),
    );
  }
}


class DatingCard extends StatelessWidget {
  final String title;
  final String profileImageUrl;
  final String name;
  final int age;
  final String distance;
  final String date;
  final String time;
  final String location;

  const DatingCard({
    Key? key,
    required this.title,
    required this.profileImageUrl,
    required this.name,
    required this.age,
    required this.distance,
    required this.date,
    required this.time,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF6C63FF)),
                    const SizedBox(width: 8.0),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
            Divider(
              color: Colors.grey[300], // Color of the line
              thickness: 1.0, // Thickness of the line
              indent: 6.0, // Left indentation
              endIndent: 6.0, // Right indentation
            ),
            // User Info Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture with Border
                Container(
                  width: 66.0,
                  height: 66.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF6C63FF), // Border color
                      width: 3.0, // Border width
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                ),
                const SizedBox(width: 12.0),
                // Name and Distance
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name - $age',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        distance,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Action Icons
                Row(
                  children: const [
                    Icon(Icons.chat_bubble, color: Color(0xFF6C63FF)),
                    SizedBox(width: 16.0),
                    Icon(Icons.phone, color: Color(0xFF6C63FF)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Date and Location Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Row
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16.0, color: Colors.grey),
                        const SizedBox(width: 8.0),
                        Text(
                          date,
                          style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0), // Space between Date and Time rows
                    // Time Row
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16.0, color: Colors.grey),
                        const SizedBox(width: 8.0),
                        Text(
                          time,
                          style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                // Location Row
                VerticalDivider(
                  color: Colors.grey[300], // Line color
                  thickness: 1.0, // Line thickness
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      const Icon(Icons.location_on, size: 16.0, color: Colors.grey),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: AutoSizeText(
                          softWrap: true,
                          "$location",
                          style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis, // Handles overflow with ellipsis
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
