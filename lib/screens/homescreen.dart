import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather360_latest_verion/models/controller.dart';
import 'package:weather360_latest_verion/models/current_weather_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(Controller());

  String degree = "°C";

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy - MMMM - dd').format(now);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Obx(
          () => controller.isloading.value == true
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: FutureBuilder(
                    future: controller.currentWeatherData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        CurrentWeatherData data = snapshot.data;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${data.name}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Image.asset(
                                  "assets/images/weatherlogo.png",
                                  width: 150,
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Text(
                                          formattedDate,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "${data.main!.temp}$degree",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 65,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text("${data.weather![0].main}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.wind_power_outlined,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "  Wind  -  ${data.wind!.speed} km/h",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.water_drop,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "  Humidity  -  ${data.main!.humidity}%",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                        );
                      }
                    },
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                ),
        ),
      ),
    );
  }
}
