import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});
  @override
  State<UploadImage> createState() => _UploadImageState();
}
class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  // this function work to pick image from the gallery
  Future getImage () async{
    final pickedFile = await  _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
      if(pickedFile!=null){
        image = File(pickedFile.path);
        setState(() {

        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Image is not selected '),
          backgroundColor: Colors.red,),
        );
      }
  }
  // In this function work to upload image to the server
  Future<void>uploadImage () async{
   setState(() {
     showSpinner =true;
   });
   var stream = new http.ByteStream(image!.openRead());
   stream.cast();
   var length = await image!.length();
   var uri = Uri.parse("https://fakestoreapi.com/products");
   // sending request to the server
    var request = new http.MultipartRequest("POST", uri);
    request.fields['title'] = "Static Title";
    //now we are assigning image to multipartFile
    var multpart = new http.MultipartFile(
        // now we are passing the actual parameters
        'image',
        stream ,
        length);
     request.files.add(multpart);
     // now we are waiting for response
       var response = await request.send();
       if(response.statusCode ==200 || response.statusCode ==201){
         setState(() {
           showSpinner =false;
           ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(
                 content: Text("Image uploaded successfully!"),
                 backgroundColor: Colors.green,
               ),
           );
         });
       }else{
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text("Image Failed  ",),
             backgroundColor: Colors.red,

           )
         );
         setState(() {
           showSpinner = false;
         });
       }
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner ,
      child: Scaffold(
        appBar: AppBar(title: Text("Upload Image"), centerTitle: true),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null
                    ? Center(child: Text("Pick Your Image"))
                    : Container(
                        child: Center(
                          child: Image.file(
                              File(
                                  image!.path
                              ).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed:(){
              uploadImage();
            }, child: Text("Upload Image")
            ),
          ],
        ),
      ),
    );
  }
}
