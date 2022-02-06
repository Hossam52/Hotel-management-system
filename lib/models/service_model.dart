class ServiceModel {
  final String name;
  final String imagePath;
  bool isSelected;
  ServiceModel(
      {required this.name, required this.imagePath, this.isSelected = false});
}

final List<ServiceModel> servicesToday = [
  ServiceModel(
      name: 'Laundary',
      imagePath: 'assets/images/laundary.png',
      isSelected: true),
  ServiceModel(name: 'Electricity', imagePath: 'assets/images/electricity.png'),
  ServiceModel(name: 'Default', imagePath: 'assets/images/laundary.png'),
  ServiceModel(name: 'Another', imagePath: 'assets/images/electricity.png'),
  ServiceModel(name: 'Shop', imagePath: 'assets/images/laundary.png'),
];
