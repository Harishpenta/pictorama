import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pictorama/features/dashboard/presenter/cubit/dashboard_cubit.dart';
import 'package:pictorama/features/dashboard/presenter/widgets/trending_wallpapers.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late DashboardCubit dashboardCubit;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text(''),
      //   iconTheme: const IconThemeData(
      //     color: Colors.black, // Set the color of the drawer icon
      //   ),
      // ),
      drawer: const Drawer(),
      body: SafeArea(
        bottom: false,
        top: true,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Text(
                      'Featured.',
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height * 0.30,
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://static.vecteezy.com/system/resources/previews/032/242/170/non_2x/beautiful-waterfall-flowers-water-nature-waterfall-hd-wallpaper-ai-generated-free-photo.jpg'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(13),
                      ),
                      child: CachedNetworkImage(
                        height: 100,
                        width: 130,
                        imageUrl:
                            'https://static.vecteezy.com/system/resources/previews/032/242/170/non_2x/beautiful-waterfall-flowers-water-nature-waterfall-hd-wallpaper-ai-generated-free-photo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(13),
                      ),
                      child: CachedNetworkImage(
                        height: 100,
                        width: 125,
                        imageUrl:
                            'https://static.vecteezy.com/system/resources/previews/032/242/170/non_2x/beautiful-waterfall-flowers-water-nature-waterfall-hd-wallpaper-ai-generated-free-photo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(13),
                      ),
                      child: Container(
                        height: 100,
                        width: 125,
                        color: const Color.fromARGB(255, 255, 172, 64),
                        child: Center(
                          child: Text(
                            '+4',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TrendingWallPapers(
                scrollController: scrollController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
