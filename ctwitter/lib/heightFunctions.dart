double getHeight(double height) {
  var drawingHeight = 797.7;
  var screenHeight = 781;

  return (height / drawingHeight) * screenHeight;
}

double getWidth(double width) {
  var drawingWidth = 376;
  var screenWidth = 392.7;

  return (width / drawingWidth) * screenWidth;
}
