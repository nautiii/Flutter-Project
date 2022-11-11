class PictureModel {
  PictureModel(
    this.id,
    this.userId,
    this.base64,
  );

  PictureModel.fromQuery(Map<String, dynamic> query)
      : id = query['id'],
        userId = query['user_id'],
        base64 = query['base64'];

  final String id;
  final String userId;
  final String base64;
}
