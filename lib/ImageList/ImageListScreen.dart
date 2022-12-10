import 'package:centre_source/ImageList/ImageFullScreen.dart';
import 'package:centre_source/ImageList/image_list_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageListScreen extends StatefulWidget {
  ImageListScreen({Key? key}) : super(key: key);

  @override
  State<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  TextEditingController searchController = TextEditingController();
ScrollController? scrollController = ScrollController();
  int itemCount=8;
  initializeScrollController(){
    scrollController?.addListener(() {
      if(scrollController?.position.pixels==scrollController?.position.maxScrollExtent){
        setState(() {
          itemCount=itemCount+6;
        });
      }
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeScrollController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("PixaBay",style: TextStyle(color: Colors.black),),
      ),
      body: BlocProvider(
        create: (context) => ImageListCubit(),
        child: BlocConsumer<ImageListCubit, ImageListState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = context.read<ImageListCubit>();
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  hintText: "Search here....",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16))),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cubit.callImageAPI(searchController.text);
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child:
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  state is ImageListSuccess
                      ? Expanded(
                          child: Container(
                            child: GridView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount: itemCount<num.parse("${state.imageModel?.hits?.length}") ?itemCount:
                              state.imageModel?.hits?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return ImageFullScreen(imageURL: "${state.imageModel?.hits?.elementAt(index).largeImageURL}");
                                      }));
                                    },
                                    child: Image.network(
                                        "${state.imageModel?.hits?.elementAt(index).largeImageURL}"),
                                  ),
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1
                              ),
                            ),
                          ),
                        )
                      : state is ImageListLoading
                          ? CircularProgressIndicator()
                          : Container()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
