Widget itemCard(Candidate candidate) {
  final mediaQuery = MediaQuery.of(context);
  final timeTextStyle = TextStyle(
      fontSize: mediaQuery.size.width / 30, color: AppPallete.black8);

  Future<void> save(Candidate candidate) async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Сохранить файл как...',
      fileName: '/home/andrey/Pictures/' + candidate.insertDate!.replaceAll(' ', '-') + p.extension(candidate.filename as String),
//        fileName: candidate.filename
    );

    if (outputFile != null) {
      print('----------==============-----------++++++++++++');
      print(outputFile);
      try {
        File file = File(outputFile);
        file.create();
        file.writeAsBytes(base64Decode(candidate.filedata!));
      } catch (e) {
        print('----------------------------');
        print(e);
      }
    }
  }

  return FutureBuilder<Candidate>(
      future: getFile(candidate),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        return Card(
          color: AppPallete.black2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: InkWell(
            onTap: () {
              print(snapshot.data?.filename);
              print(p.extension(snapshot.data?.filename as String));
              save(snapshot.data as Candidate);
            },
            child: Container(

              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: MemoryImage(base64Decode((snapshot.data?.filedata) as String)),
                ),
                borderRadius: BorderRadius.circular(50),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      height: 10,
                      width: mediaQuery.size.width,
                      child: Text((snapshot.data?.name) as String)),
                ],
              ),
            ),
          ),
        );
      });
}