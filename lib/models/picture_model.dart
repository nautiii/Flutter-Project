class PictureModel {
  PictureModel(
    this.userId,
    this.base64,
  );

  PictureModel.fromQuery(Map<String, dynamic> query)
      : userId = query['user_id'],
        base64 = query['base64'];

  final String userId;
  final String base64;
}
