class UnbordingContent {
  String? image;
  String? title;
  String? discription;

  UnbordingContent({this.image, this.title, this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'A reader lives a thousand lives',
      image: 'images/b1.png',
      discription: "The man who never reads lives only one "),
  UnbordingContent(
      title: 'Search & purchase',
      image: 'images/b3.png',
      discription: "Find the perfect book"),
  UnbordingContent(
      title: 'Today a reader, tomorrow a leader',
      image: 'images/b2.png',
      discription: "Start your journey"),
];
